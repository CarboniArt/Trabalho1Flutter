import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class DetalhesCotacaoWidget extends StatelessWidget {
  final Map<String, dynamic> data;

  const DetalhesCotacaoWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final preco = data['regularMarketPrice']?.toStringAsFixed(2) ?? '-';
    final variacao = data['regularMarketChange']?.toStringAsFixed(2) ?? '-';
    final variacaoPercent =
        data['regularMarketChangePercent']?.toStringAsFixed(2) ?? '-';
    final isPositive = (data['regularMarketChange'] ?? 0) >= 0;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: CoresApp.fundoCard,
              border: Border.all(color: CoresApp.azulBrapi2, width: 2),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: CoresApp.azulBrapi2.withOpacity(0.25),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: CoresApp.azulBrapi2.withOpacity(0.15),
                      border: Border.all(
                        color: CoresApp.azulBrapi2,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      data['symbol'] ?? '-',
                      style: const TextStyle(
                        color: CoresApp.azulBrapi2,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 4,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    (data['shortName'] ?? data['longName'] ?? '-')
                        .toUpperCase(),
                    style: const TextStyle(
                      color: CoresApp.textoBranco70,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 25),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'R\$ ',
                        style: TextStyle(
                          color: CoresApp.textoBranco70,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        preco,
                        style: const TextStyle(
                          color: CoresApp.textoBranco,
                          fontSize: 52,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                          height: 1,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isPositive
                          ? CoresApp.verde.withOpacity(0.15)
                          : CoresApp.vermelho.withOpacity(0.15),
                      border: Border.all(
                        color: isPositive ? CoresApp.verde : CoresApp.vermelho,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isPositive
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          color: isPositive
                              ? CoresApp.verde
                              : CoresApp.vermelho,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'R\$ $variacao ($variacaoPercent%)',
                          style: TextStyle(
                            color: isPositive
                                ? CoresApp.verde
                                : CoresApp.vermelho,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 15),


          Container(
            decoration: BoxDecoration(
              color: CoresApp.fundoCard,
              border: Border.all(color: CoresApp.textoAzul, width: 1.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildInfoRow(
                    'ABERTURA',
                    'R\$ ${data['regularMarketOpen']?.toStringAsFixed(2) ?? '-'}',
                  ),
                  Divider(color: CoresApp.textoAzul.withOpacity(0.4)),
                  _buildInfoRow(
                    'MÁXIMA',
                    'R\$ ${data['regularMarketDayHigh']?.toStringAsFixed(2) ?? '-'}',
                  ),
                  Divider(color: CoresApp.textoAzul.withOpacity(0.4)),
                  _buildInfoRow(
                    'MÍNIMA',
                    'R\$ ${data['regularMarketDayLow']?.toStringAsFixed(2) ?? '-'}',
                  ),
                  Divider(color: CoresApp.textoAzul.withOpacity(0.4)),
                  _buildInfoRow(
                    'FECH. ANTERIOR',
                    'R\$ ${data['regularMarketPreviousClose']?.toStringAsFixed(2) ?? '-'}',
                  ),
                  Divider(color: CoresApp.textoAzul.withOpacity(0.4)),
                  _buildInfoRow(
                    'VOLUME',
                    _formatVolume(data['regularMarketVolume']),
                  ),
                  Divider(color: CoresApp.textoAzul.withOpacity(0.4)),
                  _buildInfoRow('MOEDA', data['currency'] ?? '-'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: CoresApp.textoAzul,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: CoresApp.textoBranco,
            fontSize: 16,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  String _formatVolume(dynamic volume) {
    if (volume == null) return '-';
    if (volume >= 1000000000) return '${(volume / 1e9).toStringAsFixed(2)}B';
    if (volume >= 1000000) return '${(volume / 1e6).toStringAsFixed(2)}M';
    if (volume >= 1000) return '${(volume / 1e3).toStringAsFixed(2)}K';
    return volume.toString();
  }
}
