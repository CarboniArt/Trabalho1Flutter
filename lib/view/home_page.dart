// ignore_for_file: deprecated_member_use

import 'buscar_cotacao_page.dart';
import 'package:flutter/material.dart';
import 'listar_acoes_page.dart';
import 'comparar_acoes_page.dart';
import '../utils/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CoresApp.fundoCard,
        // icone e titulo centralizado
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.show_chart,
              color: CoresApp.azulPrincipal,
              size: 30,
            ),
            const SizedBox(width: 10),
            Text(
              'COTAÇÕES B3',
              style: TextStyle(
                color: CoresApp.textoBranco,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.5,
                fontSize: 18,
              ),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: CoresApp.fundoEscuro,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            _buildMenuCard(
              context,
              icon: Icons.search,
              title: "BUSCAR COTAÇÃO",
              subtitle: "SISTEMA DE CONSULTA EM TEMPO REAL",
              onTap: () => Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const BuscarCotacaoPage(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              ),
            ),
            const SizedBox(height: 15),
            _buildMenuCard(
              context,
              icon: Icons.list,
              title: "AÇÕES POPULARES",
              subtitle: "VISUALIZE AS PRINCIPAIS AÇÕES DO MERCADO",
              onTap: () => Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => ListarAcoesPage(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              ),
            ),
            const SizedBox(height: 15),
            _buildMenuCard(
              context,
              icon: Icons.compare_arrows,
              title: "COMPARAR AÇÕES",
              subtitle: "COMPARE DUAS AÇÕES LADO A LADO",
              onTap: () => Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const CompararAcoesPage(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: CoresApp.fundoCard,
          border: Border.all(color: CoresApp.azulPrincipal, width: 2),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: CoresApp.azulPrincipal.withOpacity(0.20),
              blurRadius: 8,
              spreadRadius: 0,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: CoresApp.azulPrincipal.withOpacity(0.1),
                border: Border.all(color: CoresApp.azulPrincipal, width: 1.5),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(icon, color: CoresApp.azulPrincipal, size: 32.0),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: CoresApp.textoBranco,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: CoresApp.textoAzul,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward,
              color: CoresApp.azulPrincipal,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
