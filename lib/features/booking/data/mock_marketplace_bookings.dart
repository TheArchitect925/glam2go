import '../domain/models/booking_models.dart';
import '../domain/models/marketplace_booking_models.dart';

final List<MarketplaceBookingRecord> mockMarketplaceBookings = [
  MarketplaceBookingRecord(
    id: 'bk-upcoming-bridal',
    customerId: 'customer-sana',
    customerName: 'Sana Malik',
    artistId: 'aaliyah-noor',
    artistName: 'Aaliyah Noor',
    packageId: 'bridal-signature',
    packageTitle: 'Signature Bridal',
    status: BookingLifecycleStatus.accepted,
    scheduledAt: DateTime(2026, 4, 12),
    timeLabel: '9:00 AM',
    isUpcoming: true,
    location: BookingLocation(
      addressLine1: '121 King Street West',
      unitDetails: 'Unit 1804',
      cityArea: 'Toronto',
      accessNotes: 'Concierge access after 8 AM',
    ),
    eventDetails: BookingEventDetails(
      occasion: 'Bridal',
      partySize: 1,
      notes: 'Soft radiant skin with a fuller lash.',
    ),
    travelFeeSummary: TravelFeeSummary(
      isIncluded: true,
      locationKnown: true,
      fee: 0,
    ),
    priceSummary: BookingPriceSummary(subtotal: 320, travelFee: 0, total: 320),
    requestedAt: DateTime(2026, 3, 20, 10, 30),
    originatedAsGuest: false,
    nextStepNote:
        'Your artist has accepted this request. Arrival timing and prep reminders will be shared before the appointment.',
    policySummary:
        'Changes to bridal bookings should be requested as early as possible to protect start times.',
    timeline: [
      BookingStatusTimelineEntry(
        status: BookingLifecycleStatus.pendingArtistResponse,
        occurredAt: DateTime(2026, 3, 20, 10, 30),
        note: 'Booking request submitted for artist review.',
      ),
      BookingStatusTimelineEntry(
        status: BookingLifecycleStatus.accepted,
        occurredAt: DateTime(2026, 3, 21, 9, 00),
        note: 'Artist accepted the request and held the requested time.',
      ),
    ],
  ),
  MarketplaceBookingRecord(
    id: 'bk-upcoming-mehndi',
    customerId: 'customer-sana',
    customerName: 'Sana Malik',
    artistId: 'aaliyah-noor',
    artistName: 'Aaliyah Noor',
    packageId: 'nikkah-soft-luxe',
    packageTitle: 'Nikkah Soft Luxe',
    status: BookingLifecycleStatus.pendingArtistResponse,
    scheduledAt: DateTime(2026, 4, 18),
    timeLabel: '5:30 PM',
    isUpcoming: true,
    location: BookingLocation(
      addressLine1: '88 Confederation Parkway',
      unitDetails: '',
      cityArea: 'Mississauga',
      accessNotes: 'Front driveway parking available.',
    ),
    eventDetails: BookingEventDetails(
      occasion: 'Henna / Mehndi',
      partySize: 1,
      notes: 'Need a warm bronze eye look for evening photos.',
    ),
    travelFeeSummary: TravelFeeSummary(
      isIncluded: true,
      locationKnown: true,
      fee: 0,
    ),
    priceSummary: BookingPriceSummary(subtotal: 210, travelFee: 0, total: 210),
    requestedAt: DateTime(2026, 3, 24, 18, 10),
    originatedAsGuest: false,
    nextStepNote:
        'Your request is waiting on the artist to review timing, travel, and event details.',
    policySummary:
        'Travel and start time are rechecked during approval for festive evening bookings.',
    timeline: [
      BookingStatusTimelineEntry(
        status: BookingLifecycleStatus.pendingArtistResponse,
        occurredAt: DateTime(2026, 3, 24, 18, 10),
        note: 'Booking request submitted and is awaiting artist response.',
      ),
    ],
  ),
  MarketplaceBookingRecord(
    id: 'bk-past-grad',
    customerId: 'customer-sana',
    customerName: 'Sana Malik',
    artistId: 'emilia-hart',
    artistName: 'Emilia Hart',
    packageId: 'grad-polish',
    packageTitle: 'Graduation Polish',
    status: BookingLifecycleStatus.completed,
    scheduledAt: DateTime(2026, 2, 22),
    timeLabel: '10:30 AM',
    isUpcoming: false,
    location: BookingLocation(
      addressLine1: '200 University Avenue',
      unitDetails: 'Suite 605',
      cityArea: 'Toronto',
      accessNotes: 'Ask concierge for studio floor access.',
    ),
    eventDetails: BookingEventDetails(
      occasion: 'Graduation',
      partySize: 1,
      notes: 'Fresh, photo-friendly finish with natural lash enhancement.',
    ),
    travelFeeSummary: TravelFeeSummary(
      isIncluded: false,
      locationKnown: true,
      fee: 20,
    ),
    priceSummary: BookingPriceSummary(subtotal: 170, travelFee: 20, total: 190),
    requestedAt: DateTime(2026, 2, 10, 14, 45),
    originatedAsGuest: false,
    nextStepNote:
        'This appointment is complete. Rebooking can reuse your saved details later.',
    policySummary:
        'Completed appointments keep their original travel and pricing summary for reference.',
    timeline: [
      BookingStatusTimelineEntry(
        status: BookingLifecycleStatus.pendingArtistResponse,
        occurredAt: DateTime(2026, 2, 10, 14, 45),
        note: 'Booking request submitted for artist approval.',
      ),
      BookingStatusTimelineEntry(
        status: BookingLifecycleStatus.accepted,
        occurredAt: DateTime(2026, 2, 11, 9, 00),
        note: 'Artist accepted the request and confirmed the booking.',
      ),
      BookingStatusTimelineEntry(
        status: BookingLifecycleStatus.completed,
        occurredAt: DateTime(2026, 2, 22, 13, 00),
        note: 'Appointment completed successfully.',
      ),
    ],
  ),
];
