import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterhole/dependency_injection.dart';
import 'package:flutterhole/features/routing/presentation/widgets/default_drawer.dart';
import 'package:flutterhole/features/settings/presentation/blocs/settings_bloc.dart';
import 'package:flutterhole/features/settings/presentation/pages/pihole_settings_page.dart';
import 'package:flutterhole/widgets/layout/animated_opener.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
        bloc: getIt<SettingsBloc>(),
        condition: (SettingsState previous, SettingsState next) {
          if (previous is SettingsStateSuccess) return false;

          return true;
        },
        builder: (BuildContext context, SettingsState state) {
          return Scaffold(
            drawer: DefaultDrawer(),
            appBar: AppBar(
              title: state.maybeWhen<Widget>(
                success: (all, active) {
                  return Text('${active?.title}');
                },
                orElse: () => Text('FlutterHole'),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    getIt<SettingsBloc>().add(SettingsEventCreate());
                  },
                ),
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    getIt<SettingsBloc>().add(SettingsEventInit());
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    getIt<SettingsBloc>().add(SettingsEventReset());
                  },
                ),
              ],
            ),
            body: state.maybeWhen<Widget>(
              success: (all, active) {
                return ListView.builder(
                    itemCount: all.length,
                    itemBuilder: (context, index) {
                      final settings = all.elementAt(index);
                      return AnimatedOpener(
                        closed: (context) => ListTile(
                          title: Text('${settings.title}'),
                          trailing: Visibility(
                            visible: settings == active,
                            child: Icon(Icons.check),
                          ),
                          onLongPress: () {
                            getIt<SettingsBloc>()
                                .add(SettingsEvent.activate(settings));
                          },
                        ),
                        opened: (context) =>
                            PiholeSettingsPage(initialValue: settings),
                      );
                    });
              },
              orElse: () {
                return Center(
                  child: Text('hello'),
                );
              },
            ),
          );
        });
  }
}