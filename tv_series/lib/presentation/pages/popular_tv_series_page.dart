import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';

import '../widgets/tv_series_card_list.dart';

class PopularTvSeriesPage extends StatefulWidget {
  static const routeName = '/popular-tv-series';

  const PopularTvSeriesPage({super.key});

  @override
  State<PopularTvSeriesPage> createState() => _PopularTvSeriesPageState();
}

class _PopularTvSeriesPageState extends State<PopularTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvSeriesPopularBloc>().add(TvSeriesPopularGetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvSeriesPopularBloc, TvSeriesPopularState>(
          builder: (context, state) {
            if (state is TvSeriesPopularLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is TvSeriesPopularLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSerie = state.tvSeries[index];
                  return TvSeriesCard(tvSerie);
                },
                itemCount: state.tvSeries.length,
              );
            }
            if (state is TvSeriesPopularError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            }
            return const Text('No Data');
          },
        ),
      ),
    );
  }
}
