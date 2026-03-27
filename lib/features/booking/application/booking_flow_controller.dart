import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../search/application/discovery_providers.dart';
import '../../search/domain/models/discovery_models.dart';
import '../domain/models/booking_models.dart';

final bookingFlowControllerProvider =
    NotifierProvider<BookingFlowController, BookingDraft>(
      BookingFlowController.new,
    );

final bookingAvailableDatesProvider = Provider<List<BookingDateSelection>>((
  ref,
) {
  final draft = ref.watch(bookingFlowControllerProvider);
  final artistId = draft.artistId;

  if (artistId == null) {
    return const <BookingDateSelection>[];
  }

  final formatter = DateFormat('EEE d MMM');
  final baseDate = DateTime(2026, 4, 10);
  final offset = artistId.hashCode.abs() % 3;

  return List.generate(6, (index) {
    final date = baseDate.add(Duration(days: offset + index));
    return BookingDateSelection(date: date, label: formatter.format(date));
  });
});

final bookingAvailableTimeSlotsProvider = Provider<List<BookingTimeSelection>>((
  ref,
) {
  final selectedDate = ref.watch(
    bookingFlowControllerProvider.select((draft) => draft.dateSelection),
  );

  if (selectedDate == null) {
    return const <BookingTimeSelection>[];
  }

  final weekday = selectedDate.date.weekday;
  final morningSlots = const [
    BookingTimeSelection(label: '9:00 AM', time24h: '09:00'),
    BookingTimeSelection(label: '10:30 AM', time24h: '10:30'),
    BookingTimeSelection(label: '12:00 PM', time24h: '12:00'),
  ];
  final afternoonSlots = const [
    BookingTimeSelection(label: '1:30 PM', time24h: '13:30'),
    BookingTimeSelection(label: '3:00 PM', time24h: '15:00'),
    BookingTimeSelection(label: '5:30 PM', time24h: '17:30'),
  ];

  return weekday >= DateTime.friday ? afternoonSlots : morningSlots;
});

final currentBookingArtistProfileProvider = Provider<ArtistProfile?>((ref) {
  final artistId = ref.watch(
    bookingFlowControllerProvider.select((draft) => draft.artistId),
  );

  if (artistId == null) {
    return null;
  }

  return ref.watch(artistProfileSnapshotProvider(artistId));
});

final bookingConfirmationProvider =
    Provider.family<BookingConfirmationDetails?, String>((ref, bookingId) {
      final details = ref.watch(
        bookingFlowControllerProvider.select(
          (draft) => draft.confirmationDetails,
        ),
      );
      if (details?.bookingId != bookingId) {
        return null;
      }

      return details;
    });

class BookingFlowController extends Notifier<BookingDraft> {
  @override
  BookingDraft build() {
    return BookingDraft.initial();
  }

  void startFlow({required String artistId, String? preselectedPackageId}) {
    final profile = ref.read(artistProfileSnapshotProvider(artistId));
    if (profile == null) {
      return;
    }

    ArtistPackage? selectedPackage;
    if (preselectedPackageId != null) {
      for (final artistPackage in profile.packages) {
        if (artistPackage.id == preselectedPackageId) {
          selectedPackage = artistPackage;
          break;
        }
      }
    }

    final packageSelection = selectedPackage == null
        ? null
        : SelectedServicePackage.fromArtistPackage(selectedPackage);

    final baseState = BookingDraft.initial().copyWith(
      step: BookingFlowStep.service,
      artistId: profile.summary.id,
      artistName: profile.summary.name,
      artistLocationLabel: profile.summary.locationLabel,
      artistTravelPolicy: profile.travelPolicy,
      availablePackages: profile.packages,
      selectedPackage: packageSelection,
    );

    state = _recalculate(baseState);
  }

  void selectPackage(ArtistPackage artistPackage) {
    state = _recalculate(
      state.copyWith(
        selectedPackage: SelectedServicePackage.fromArtistPackage(
          artistPackage,
        ),
      ),
    );
  }

  void updateEventDetails({
    required String occasion,
    required int partySize,
    required String notes,
  }) {
    state = state.copyWith(
      eventDetails: BookingEventDetails(
        occasion: occasion,
        partySize: partySize,
        notes: notes.trim(),
      ),
    );
  }

  void selectDate(BookingDateSelection selection) {
    state = state.copyWith(dateSelection: selection, clearTimeSelection: true);
  }

  void selectTime(BookingTimeSelection selection) {
    state = state.copyWith(timeSelection: selection);
  }

  void updateLocation({
    required String addressLine1,
    required String unitDetails,
    required String cityArea,
    required String accessNotes,
  }) {
    final location = BookingLocation(
      addressLine1: addressLine1.trim(),
      unitDetails: unitDetails.trim(),
      cityArea: cityArea.trim(),
      accessNotes: accessNotes.trim(),
    );

    state = _recalculate(state.copyWith(location: location));
  }

  void setStep(BookingFlowStep step) {
    state = state.copyWith(step: step);
  }

  void setConfirmationDetails(BookingConfirmationDetails details) {
    state = state.copyWith(
      step: BookingFlowStep.confirmation,
      confirmationDetails: details,
    );
  }

  void clearConfirmationDetails() {
    state = state.copyWith(clearConfirmationDetails: true);
  }

  BookingDraft _recalculate(BookingDraft draft) {
    final travelFeeSummary = _buildTravelSummary(draft);
    final subtotal = draft.selectedPackage?.price ?? 0;
    final travelFee = travelFeeSummary.fee;

    return draft.copyWith(
      travelFeeSummary: travelFeeSummary,
      priceSummary: BookingPriceSummary(
        subtotal: subtotal,
        travelFee: travelFee,
        total: subtotal + travelFee,
      ),
    );
  }

  TravelFeeSummary _buildTravelSummary(BookingDraft draft) {
    final travelPolicy = draft.artistTravelPolicy;
    if (travelPolicy == null) {
      return const TravelFeeSummary(
        isIncluded: true,
        locationKnown: false,
        fee: 0,
      );
    }

    final cityArea = draft.location?.cityArea.toLowerCase() ?? '';
    final artistBase = draft.artistLocationLabel?.toLowerCase() ?? '';

    if (cityArea.isEmpty) {
      return TravelFeeSummary(isIncluded: true, locationKnown: false, fee: 0);
    }

    final travelIncluded =
        cityArea.contains('toronto') && artistBase.contains('toronto') ||
        cityArea.contains('mississauga') &&
            artistBase.contains('mississauga') ||
        cityArea.contains('scarborough') &&
            artistBase.contains('scarborough') ||
        cityArea.contains('north york') && artistBase.contains('north york');

    if (travelIncluded) {
      return TravelFeeSummary(isIncluded: true, locationKnown: true, fee: 0);
    }

    return TravelFeeSummary(
      isIncluded: false,
      locationKnown: true,
      fee: travelPolicy.extraFeeFrom,
    );
  }
}
