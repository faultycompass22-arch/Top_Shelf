import 'package:flutter/material.dart';

class VintageCrateTile extends StatelessWidget {
  final String strainName;        // "MAUI WOWIE"
  final double thcaPercent;       // 24.0
  final double price;             // 35.0
  final String unitLabel;         // "/ 3.5g"
  final String? tinyNote;         // "Tax included"
  final ImageProvider image;      // NetworkImage(...) or AssetImage(...)
  final VoidCallback? onTap;

  const VintageCrateTile({
    super.key,
    required this.strainName,
    required this.thcaPercent,
    required this.price,
    this.unitLabel = "/ 3.5g",
    this.tinyNote,
    required this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Tune these once and the whole brand stays consistent
    const borderRadius = 22.0;
    const woodBorder = 14.0;
    const innerRadius = 16.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          // Wood frame background (use your wood image asset here)
          image: const DecorationImage(
            image: AssetImage("assets/ui/wood_frame.png"),
            fit: BoxFit.cover,
          ),
          boxShadow: const [
            BoxShadow(
              blurRadius: 14,
              offset: Offset(0, 8),
              color: Colors.black26,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Stack(
            children: [
              // Slight vignette / “oiled spot” behind the inner white card
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.center,
                      radius: 0.95,
                      colors: [
                        Colors.black.withValues(alpha: 0.28),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.85],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(woodBorder),
                child: _InnerWhiteCard(
                  image: image,
                  strainName: strainName,
                  thcaPercent: thcaPercent,
                  price: price,
                  unitLabel: unitLabel,
                  tinyNote: tinyNote,
                  innerRadius: innerRadius,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InnerWhiteCard extends StatelessWidget {
  final ImageProvider image;
  final String strainName;
  final double thcaPercent;
  final double price;
  final String unitLabel;
  final String? tinyNote;
  final double innerRadius;

  const _InnerWhiteCard({
    required this.image,
    required this.strainName,
    required this.thcaPercent,
    required this.price,
    required this.unitLabel,
    required this.tinyNote,
    required this.innerRadius,
  });

  @override
  Widget build(BuildContext context) {
    // Cream / gold vibe (you can swap these to your exact theme values later)
    const cream = Color(0xFFF3E8D0);
    const ink = Color(0xFF3B2A1F);

    return Container(
      decoration: BoxDecoration(
        color: cream,
        borderRadius: BorderRadius.circular(innerRadius),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            offset: Offset(0, 6),
            color: Colors.black26,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(innerRadius),
        child: Column(
          children: [
            // Image area
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image(
                      image: image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),

            // Text block (exact hierarchy like the mock)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 4, 14, 14),
              child: Column(
                children: [
                  Text(
                    strainName.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: "Cinzel", // or your vintage serif
                      fontSize: 18,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w700,
                      color: ink,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "THCA ${thcaPercent.toStringAsFixed(0)}%",
                    style: const TextStyle(
                      fontFamily: "Cinzel",
                      fontSize: 14,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w600,
                      color: ink,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "\$${price.toStringAsFixed(0)} $unitLabel",
                    style: const TextStyle(
                      fontFamily: "Cinzel",
                      fontSize: 16,
                      letterSpacing: 0.6,
                      fontWeight: FontWeight.w800,
                      color: ink,
                    ),
                  ),
                  if (tinyNote != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      tinyNote!,
                      style: TextStyle(
                        fontSize: 10.5,
                        color: ink.withValues(alpha: 0.7),
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}