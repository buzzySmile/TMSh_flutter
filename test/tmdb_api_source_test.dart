import 'dart:io';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:tmsh_flutter/data/api_key.dart';
import 'package:tmsh_flutter/data/models/tmdb_movie_card.dart';
import 'package:tmsh_flutter/data/models/tmdb_movie_error.dart';
import 'package:tmsh_flutter/data/models/tmdb_search_error.dart';
import 'package:tmsh_flutter/data/models/tmdb_search_movies.dart';
import 'package:tmsh_flutter/data/tmdb_api_source.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  String mockOf(String name) =>
      File('test/mocks/$name.json').readAsStringSync();

  late MockClient mockClient;
  late TMDbApiSource dataSource;

  setUp(() {
    mockClient = MockClient();
    dataSource = TMDbApiSource(mockClient);
  });

  group('searchVideos', () {
    test(
      'returns TMDbSearchResult when the call completes successfully',
      () async {
        when(
          mockClient.get(
            argThat(
              startsWith('https://api.themoviedb.org/3/search/movie'),
            )!,
          ),
        ).thenAnswer(
          (_) async => http.Response(
            mockOf('search_response'),
            200,
            headers: {'content-type': 'application/json; charset=utf-8'},
          ),
        );

        TMDbSearchMovies result = await dataSource.searchMovie(
          query: 'avengers',
        );

        expect(result, TypeMatcher<TMDbSearchMovies>());
        expect(result.movies.length, 20);
        expect(result.movies[0].title, startsWith('Avengers: Endgame'));
      },
    );

    test('throws an error on bad request', () async {
      when(
        mockClient.get(
          argThat(
            startsWith('https://api.themoviedb.org/3/search/movie'),
          )!,
        ),
      ).thenAnswer(
        (_) async => http.Response(mockOf('search_response_error'), 400),
      );

      expect(
        () => dataSource.searchMovie(
          query: '',
        ),
        throwsA(TypeMatcher<TMDbSearchError>()),
      );
    });

    test('makes an HTTP request to a proper URL', () {
      when(
        mockClient.get(
          argThat(
            startsWith('https://api.themoviedb.org/3/search/movie'),
          )!,
        ),
      ).thenAnswer(
        (_) async => http.Response(
          mockOf('search_response'),
          200,
          headers: {'content-type': 'application/json; charset=utf-8'},
        ),
      );

      dataSource.searchMovie(query: 'inception');
      dataSource.searchMovie(query: 'avengers', pageIndex: 2);
      dataSource.searchMovie(query: '');

      verifyInOrder([
        mockClient.get(argThat(
          allOf(
            startsWith('https://api.themoviedb.org/3/search/movie'),
            contains('query=inception'),
            contains('api_key=$API_KEY'),
            contains('language=en-US'),
            contains('include_adult=false'),
            //isNot(contains('page')),
          ),
        )!),
        mockClient.get(argThat(
          allOf(
            startsWith('https://api.themoviedb.org/3/search/movie'),
            contains('query=avengers'),
            contains('page=2'),
            contains('api_key=$API_KEY'),
            contains('language=en-US'),
            contains('include_adult=false'),
          ),
        )!),
        mockClient.get(argThat(
          allOf(
            startsWith('https://api.themoviedb.org/3/search/movie'),
            contains('query'),
            contains('api_key=$API_KEY'),
            contains('language=en-US'),
            contains('include_adult=false'),
          ),
        )!),
      ]);
    });
  });

  group('fetchMovie', () {
    test(
      'returns TMDbMovieResponse when the call completes successfully',
      () async {
        when(
          mockClient.get(
            argThat(
              startsWith('https://api.themoviedb.org/3/movie/'),
            )!,
          ),
        ).thenAnswer(
          (_) async => http.Response(
            mockOf('movie_response'),
            200,
            headers: {'content-type': 'application/json; charset=UTF-8'},
          ),
        );

        TMDbMovieCard response =
            await dataSource.fetchMovieInfo(movieId: 27205);

        expect(response, TypeMatcher<TMDbMovieCard>());
        expect(response.id, 27205);

        verify(mockClient.get(
          argThat(
            allOf(
              startsWith('https://api.themoviedb.org/3/movie/'),
              contains('27205'),
              contains('api_key=$API_KEY'),
            ),
          )!,
        ));
      },
    );

    test('throws a TMDbMovieError on a bad request', () {
      when(
        mockClient.get(
          argThat(
            startsWith('https://api.themoviedb.org/3/movie/'),
          )!,
        ),
      ).thenAnswer(
        (_) async => http.Response(mockOf('movie_response_error'), 400),
      );

      expect(
        () => dataSource.fetchMovieInfo(movieId: 27205),
        throwsA(TypeMatcher<TMDbMovieError>()),
      );
    });

    test('makes HTTP requests to proper URLs', () {
      when(
        mockClient.get(
          argThat(
            startsWith('https://api.themoviedb.org/3/movie/'),
          )!,
        ),
      ).thenAnswer(
        (_) async => http.Response(
          mockOf('movie_response'),
          200,
          headers: {'content-type': 'application/json; charset=UTF-8'},
        ),
      );

      dataSource.fetchMovieInfo(movieId: 11);
      dataSource.fetchMovieInfo(movieId: 0);

      verifyInOrder([
        mockClient.get(
          argThat(
            allOf(
              startsWith('https://api.themoviedb.org/3/movie/'),
              contains('11'),
              contains('key=$API_KEY'),
            ),
          )!,
        ),
        mockClient.get(
          argThat(
            allOf(
              startsWith('https://api.themoviedb.org/3/movie/'),
              contains('0'),
              contains('key=$API_KEY'),
            ),
          )!,
        ),
      ]);
    });
  });
}
