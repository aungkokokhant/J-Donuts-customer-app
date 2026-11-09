const demoMemberId = 'demo';

typedef MemberProfile = ({
  String id,
  String name,
  String imageKey,
  String tier,
  String nextTier,
  int pointsToNextTier,
  int totalPoints,
  int tierStartPoints,
  int notificationCount,
  int availableRewards,
});

extension MemberTierProgress on MemberProfile {
  double get tierProgress {
    if (pointsToNextTier <= 0) return 1;
    final earnedInTier = totalPoints - tierStartPoints;
    if (earnedInTier <= 0) return 0;
    return earnedInTier / (earnedInTier + pointsToNextTier);
  }
}
