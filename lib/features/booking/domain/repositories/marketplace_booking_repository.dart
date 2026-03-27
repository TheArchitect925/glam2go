import '../../../../core/result/app_result.dart';
import '../../../session/domain/models/session_models.dart';
import '../models/booking_models.dart';
import '../models/marketplace_booking_models.dart';

abstract class MarketplaceBookingRepository {
  Future<AppResult<List<MarketplaceBookingRecord>>> loadBookings();
  Future<AppResult<MarketplaceBookingRecord>> submitBookingRequest({
    required BookingDraft draft,
    required SessionUserSummary customer,
    required bool originatedAsGuest,
  });
  Future<AppResult<MarketplaceBookingRecord>> applyArtistDecision({
    required String bookingId,
    required BookingRequestDecision decision,
  });
  Future<AppResult<MarketplaceBookingRecord>> cancelBookingRequest(
    String bookingId,
  );
}
