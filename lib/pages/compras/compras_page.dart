import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loumar/models/compra_model.dart';
import 'package:loumar/models/ingresso_models.dart' hide MockData;
import 'package:loumar/widgets/compras/compras_list.dart';
import 'package:loumar/widgets/compras/credito_loumar.dart';
import 'package:loumar/widgets/ingresso_vazio.dart';

class ComprasPage extends StatefulWidget {
  const ComprasPage({super.key});

  @override
  State<ComprasPage> createState() => _ComprasPageState();
}

class _ComprasPageState extends State<ComprasPage> {
  void _showCreditoLoumar(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return const CreditoLoumar();
      },
    );
  }

  final List<CompraModel> _compras = MockData.getCompras();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: SvgPicture.asset(
            "assets/images/ingresso/arrow_left.svg",
            width: 15,
            height: 15,
          ),
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF4E73ED),
                border: Border.all(color: const Color(0xFFEAECF5)),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Center(
                child: SvgPicture.asset(
                  "assets/images/icons/compras.svg",
                  width: 16,
                  height: 16,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(width: 16),

            const Text(
              'Minhas Compras',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Color(0xFF1E3460),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFF8F8F8),
      ),

      backgroundColor: const Color(0xFFF8F8F8),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton(
                onPressed: () => _showCreditoLoumar(context),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFD5D5D9)),
                  backgroundColor: const Color(0xFFFFFFFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/images/icons/info.svg",
                      width: 16,
                      height: 16,
                      color: const Color(0xFF1E3C89),
                    ),
        
                    const SizedBox(width: 12),
        
                    const Text(
                      "Crédito",
                      style: TextStyle(
                        fontFamily: 'Monstserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xFF1E3C89),
                      ),
                    ),
        
                    const Spacer(),
        
                    const Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          height: 1.25,
                        ),
                        children: [
                          TextSpan(
                            text: "R\$ ",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF05A4AE),
                            ),
                          ),
                          TextSpan(
                            text: "0,00",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF575467),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        
            const SizedBox(height: 24),

            Expanded(
              child: _compras.isEmpty ? const IngressoVazio() : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [ComprasList(compras: _compras)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
