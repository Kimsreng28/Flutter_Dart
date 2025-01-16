import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';

Handler middleware(Handler handler) {
  return (context) async {
    // Create a PostgreSQL connection
    final connection = PostgreSQLConnection(
        'localhost', // Hostname
        5432, // Port
        'mytasklists', // Database name
        username: 'postgres', // Username
        password: 'yourpassword' // Password
        );

    // Open the connection
    await connection.open();

    // Inject the connection into the handler
    final response = await handler
        .use(provider<PostgreSQLConnection>((_) => connection))
        .call(context);

    // Close the connection
    await connection.close();

    return response;
  };
}
