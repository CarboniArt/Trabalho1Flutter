// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../service/brapi_service.dart';
import '../components/barra_tecnologica.dart';
import '../components/detalhes_cotacao_widget.dart';
import '../utils/app_colors.dart';

class CompararAcoesPage extends StatefulWidget {
  const CompararAcoesPage({super.key});

  @override
  State<CompararAcoesPage> createState() => _CompararAcoesPageState();
}

class _CompararAcoesPageState extends State<CompararAcoesPage> {
  final _controller = TextEditingController();
  final _apiService = BrapiService();
  final _acoes = <String>[];
  List<dynamic>? _resultados;
  bool _loading = false;

  void _adicionarAcao() {
    final acao = _controller.text.toUpperCase().trim();
    if (acao.isNotEmpty && !_acoes.contains(acao) && _acoes.length < 2) {
      setState(() {
        _acoes.add(acao);
        _controller.clear();
        if (_acoes.length == 2) _compararAcoes();
      });
    }
  }

  void _removerAcao(String acao) {
    setState(() {
      _acoes.remove(acao);
      _resultados = null;
    });
  }

  Future<void> _compararAcoes() async {
    //busca os dados
    setState(() => _loading = true);
    try {
      final dados = await _apiService.buscarMultiplasCotacoes(_acoes);
      setState(() {
        _resultados = dados;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: $e'), backgroundColor: CoresApp.vermelho),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CoresApp.fundoCard,
        title: const Text(
          'COMPARAR AÇÕES',
          style: TextStyle(
            color: CoresApp.textoBranco,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.5,
          ),
        ),
        centerTitle: true,

        iconTheme: const IconThemeData(color: CoresApp.azulPrincipal),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3),
          child: BarraTecnologica(color: CoresApp.azulPrincipal),
        ),
      ),
      backgroundColor: CoresApp.fundoEscuro,

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          labelText: "CÓDIGO DA AÇÃO (EX: PETR4)",
                          labelStyle: TextStyle(
                            color: CoresApp.textoAzul,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: CoresApp.azulPrincipal, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: CoresApp.azulPrincipal, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: CoresApp.fundoCard,
                        ),

                        style: const TextStyle(
                          color: CoresApp.textoBranco,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                        ),
                        textCapitalization: TextCapitalization.characters,
                        onSubmitted: (_) => _adicionarAcao(),
                        enabled: _acoes.length < 2,
                      ),
                    ),

                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: CoresApp.azulPrincipal.withOpacity(0.1),
                        border: Border.all(color: CoresApp.azulPrincipal, width: 2),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: CoresApp.azulPrincipal.withOpacity(0.20),
                            blurRadius: 8,
                          ),
                        ],
                      ),

                      child: IconButton(
                        onPressed: _acoes.length < 2 ? _adicionarAcao : null,
                        icon: const Icon(Icons.add, color: CoresApp.azulPrincipal),
                        iconSize: 28,
                      ),
                    ),
                  ],
                ),
                if (_acoes.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    children: _acoes
                        .map(
                          (acao) => Chip(
                            label: Text(
                              acao,
                              style: const TextStyle(
                                color: CoresApp.textoBranco,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.5,
                              ),
                            ),
                            backgroundColor: CoresApp.azulPrincipal,
                            deleteIcon: const Icon(
                              Icons.close,
                              size: 18,
                              color: CoresApp.textoBranco,
                            ),
                            onDeleted: () => _removerAcao(acao),
                            side: BorderSide.none,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
          Expanded(
            child: _loading
                ? const Center(
                    child: CircularProgressIndicator(color: CoresApp.azulPrincipal),
                  )
                : _resultados != null && _resultados!.length == 2
                ? PageView.builder(
                    itemCount: 2,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: DetalhesCotacaoWidget(data: _resultados![index]),
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: CoresApp.azulPrincipal.withOpacity(0.1),
                            border: Border.all(color: CoresApp.azulPrincipal, width: 2),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Icon(
                            Icons.compare_arrows,
                            color: CoresApp.azulPrincipal,
                            size: 60,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "ADICIONE 2 AÇÕES PARA COMPARAR",
                          style: TextStyle(
                            color: CoresApp.textoAzul,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
