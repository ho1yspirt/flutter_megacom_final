import 'package:flutter/material.dart';
import 'package:flutter_megacom_final/blocs/counter/counter_bloc.dart';
import 'package:flutter_megacom_final/blocs/weather/weather_bloc.dart';
import 'package:flutter_megacom_final/features/weather/widgets/weather_button.dart';
import 'package:flutter_megacom_final/features/weather/widgets/weather_widget.dart';
import 'package:flutter_megacom_final/network/dio_client.dart';
import 'package:flutter_megacom_final/repos/counter_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_megacom_final/repos/weather_repo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

bool isDarkTheme = false;

ThemeData lightTheme = ThemeData(useMaterial3: true);

ThemeData darkTheme = ThemeData.dark(useMaterial3: true);

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    int counter = 0;

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => CounterRepo(),
        ),
        RepositoryProvider(
          create: (context) => DioClient(),
        ),
        RepositoryProvider(
          create: (context) => WeatherRepo(
            dio: RepositoryProvider.of<DioClient>(context).dio,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CounterBloc(
              repo: RepositoryProvider.of<CounterRepo>(context),
            ),
          ),
          BlocProvider(
            create: (context) => WeatherBloc(
              repo: RepositoryProvider.of<WeatherRepo>(context),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Megacom Final',
          theme: isDarkTheme ? darkTheme : lightTheme,
          home: Scaffold(
            appBar: AppBar(
              title: const Text('Megacom final task'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const WeatherWidget(),
                  const Text('You have pushed the button this many times:'),
                  BlocBuilder<CounterBloc, CounterState>(
                    builder: (context, state) {
                      if (state is CounterSuccess) {
                        counter = state.counter;
                        return Text(
                          state.counter.toString(),
                          style: Theme.of(context).textTheme.headlineMedium,
                        );
                      }
                      return Text(
                        counter.toString(),
                        style: Theme.of(context).textTheme.headlineMedium,
                      );
                    },
                  ),
                ],
              ),
            ),
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const WeatherButton(),
                      const SizedBox(height: 16),
                      FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            isDarkTheme = !isDarkTheme;
                          });
                        },
                        child: const Icon(Icons.palette_outlined),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlocBuilder<CounterBloc, CounterState>(
                      builder: (context, state) {
                        if (state is CounterSuccess) {
                          if (state.counter == 10) {
                            return const SizedBox(height: 55);
                          }
                        }
                        return FloatingActionButton(
                          onPressed: () {
                            BlocProvider.of<CounterBloc>(context).add(
                              isDarkTheme
                                  ? IncrementTwiceCounter(counter: counter)
                                  : IncrementCounter(counter: counter),
                            );
                          },
                          child: const Icon(Icons.add_rounded),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<CounterBloc, CounterState>(
                      builder: (context, state) {
                        if (state is CounterSuccess) {
                          if (state.counter == 0) {
                            return const SizedBox(height: 55);
                          }
                        }
                        return FloatingActionButton(
                          onPressed: () {
                            BlocProvider.of<CounterBloc>(context).add(
                              isDarkTheme
                                  ? DecrementTwiceCounter(counter: counter)
                                  : DecrementCounter(counter: counter),
                            );
                          },
                          child: const Icon(Icons.remove_rounded),
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
