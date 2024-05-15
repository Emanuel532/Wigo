import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wigo/providers/trip_provider.dart';
import 'package:wigo/screens/add_trip.dart';
import 'package:wigo/screens/forgot_password.dart';
import 'package:wigo/screens/sign_up_screen.dart';
import 'package:wigo/screens/home_screen.dart';
import 'package:wigo/screens/log_in_screen.dart';
import 'package:wigo/screens/view_trip.dart';
import 'package:wigo/services/authentication_utils.dart';

import 'firebase_options.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (ctx) => TripProvider())],
      child: MyApp()));
}

/// The route configuration for our app
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        print(
            'isUserAuthenticated: ${AuthenticationUtils.isUserAuthenticated()}');
        return AuthenticationUtils
                .isUserAuthenticated() //show the home screen if the user is authenticated
            ? HomeScreen()
            : LoginScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return LoginScreen();
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'create_account',
              builder: (BuildContext context, GoRouterState state) {
                return CreateAccountScreen();
              },
            ),
            GoRoute(
              path: 'forgot_password',
              builder: (BuildContext context, GoRouterState state) {
                return ForgotPasswordScreen();
              },
            )
          ],
        ),
        GoRoute(
            path: 'add-trip',
            builder: (BuildContext context, GoRouterState state) {
              return AddTripScreen();
            }),
        GoRoute(
            path: 'view-trip/:tripId',
            builder: (BuildContext context, GoRouterState state) {
              return ViewTripScreen();
            }),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initFirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while waiting for Firebase to initialize
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            //TODO: facut widget frumos + text mai explicit + separat
            child: Text('Error initializing Firebase'),
          );
        }
        return MaterialApp.router(
          routerConfig: _router,
          title: 'Wigo Trip Planner ',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
        );
      },
    );
  }
}
