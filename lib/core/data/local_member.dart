import '../domain/member_profile.dart';
import 'app_database.dart';

Future<MemberProfile?> loadLocalMember(AppDatabase db, String id) async {
  final query = db.select(db.members)..where((row) => row.id.equals(id));
  final member = await query.getSingleOrNull();
  return member == null
      ? null
      : (
          id: member.id,
          name: member.name,
          imageKey: member.imageKey,
          tier: member.tier,
          nextTier: member.nextTier,
          pointsToNextTier: member.pointsToNextTier,
          totalPoints: member.totalPoints,
          tierStartPoints: member.tierStartPoints,
          notificationCount: member.notificationCount,
          availableRewards: member.availableRewards,
        );
}
