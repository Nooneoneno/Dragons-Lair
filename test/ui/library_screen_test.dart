import 'package:DragOnPlay/entities/video_game_partial.dart';
import 'package:DragOnPlay/ui/screens/user_library_screen/library_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';

void main() {
  setUp(() async {
    await setUpTestHive();
    await Hive.openBox('userLibrary');
    await Hive.openBox('userFavourites');
  });

  tearDown(() async {
    await tearDownTestHive();
  });

  group('UserLibraryScreen Widget Tests', () {
    testWidgets('Shows empty library and favourites message',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UserLibraryScreen(),
          ),
        ),
      );

      //assert the widget is fully loaded and ready
      await tester.pumpAndSettle();
      expect(find.text('Your library is empty!'), findsOneWidget);
    });

    testWidgets('Removes game from library when delete is triggered', (WidgetTester tester) async {
      tester.runAsync(() async {
        final mockLibraryGame = VideoGamePartial(
            id: 1,
            name: 'Mock Game 1',
            coverUrl: '',
            firstReleaseDate: 0,
            releaseDate: DateTime(2024),
            rating: 95);

        var libraryBox = Hive.box('userLibrary');
        await libraryBox.put(mockLibraryGame.id, mockLibraryGame);

        await tester.pumpWidget(
          MaterialApp(
            home: UserLibraryScreen(),
          ),
        );

        await tester.pumpAndSettle();
        expect(find.text('Mock Game 1'), findsOneWidget);
        await tester.tap(find.byIcon(Icons.remove));
        await tester.pumpAndSettle();
        expect(find.text('No games in this tab! :('), findsOneWidget);
      });
    });

    testWidgets('Check if games added are in the right tab', (WidgetTester tester) async {
      tester.runAsync(() async {
        final mockLibraryGame1 = VideoGamePartial(
            id: 1,
            name: 'Mock Game 1',
            coverUrl: '',
            firstReleaseDate: 0,
            releaseDate: DateTime(2024),
            rating: 95);
        final mockLibraryGame2 = VideoGamePartial(
            id: 2,
            name: 'Mock Game 2',
            coverUrl: '',
            firstReleaseDate: 0,
            releaseDate: DateTime(2024),
            rating: 95);

        var libraryBox = Hive.box('userLibrary');
        var favouriteBox = Hive.box('userFavourites');
        await libraryBox.put(mockLibraryGame1.id, mockLibraryGame1);
        await favouriteBox.put(mockLibraryGame2.id, mockLibraryGame2);

        await tester.pumpWidget(
          MaterialApp(
            home: UserLibraryScreen(),
          ),
        );

        await tester.pumpAndSettle();
        expect(find.text('Mock Game 1'), findsOneWidget);
        expect(find.text('Mock Game 2'), findsNothing);
        await tester.tap(find.byIcon(Icons.favorite));
        await tester.pumpAndSettle();
        expect(find.text('Mock Game 1'), findsNothing);
        expect(find.text('Mock Game 2'), findsOneWidget);
      });
    });
  });
}
