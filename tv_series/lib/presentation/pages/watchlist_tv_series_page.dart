import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';

import '../widgets/tv_series_card_list.dart';

class WatchlistTvSeriesPage extends StatefulWidget {
  static const routeName = '/watchlist-tv-series';

  const WatchlistTvSeriesPage({super.key});

  @override
  State<WatchlistTvSeriesPage> createState() => _WatchlistTvSeriesPageState();
}

class _WatchlistTvSeriesPageState extends State<WatchlistTvSeriesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<TvSeriesWatchlistBloc>().add(TvSeriesWatchlistGetEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<TvSeriesWatchlistBloc>().add(TvSeriesWatchlistGetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
          builder: (context, state) {
            if (state is TvSeriesWatchlistLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is TvSeriesWatchlistLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final serie = state.tvSeries[index];
                  return TvSeriesCard(serie);
                },
                itemCount: state.tvSeries.length,
              );
            }
            if (state is TvSeriesWatchlistError) {
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

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
