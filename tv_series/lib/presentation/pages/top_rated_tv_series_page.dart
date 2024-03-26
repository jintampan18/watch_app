import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';

import '../widgets/tv_series_card_list.dart';

class TopRatedTvSeriesPage extends StatefulWidget {
  static const routeName = '/top-rated-tv-series';

  const TopRatedTvSeriesPage({super.key});

  @override
  State<TopRatedTvSeriesPage> createState() => _TopRatedTvSeriesPageState();
}

class _TopRatedTvSeriesPageState extends State<TopRatedTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvSeriesTopRatedBloc>().add(TvSeriesTopRatedGetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
          builder: (context, state) {
            if (state is TvSeriesTopRatedLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is TvSeriesTopRatedLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final serie = state.tvSeries[index];
                  return TvSeriesCard(serie);
                },
                itemCount: state.tvSeries.length,
              );
            }
            if (state is TvSeriesTopRatedError) {
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
