import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'detail_screen.dart';

class RotiListScreen extends StatelessWidget {
  Future<List<dynamic>> fetchRoti() async {
    final response = await http.get(Uri.parse(
        'http://192.168.215.210/sertifikasi_jmp/backend/get_roti.php'));

    if (response.statusCode == 200) {
      try {
        return json.decode(response.body);
      } catch (e) {
        throw Exception('Error parsing JSON: $e');
      }
    } else {
      throw Exception('Failed to load roti');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bakery App"),
        backgroundColor: Colors.brown,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchRoti(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Tidak ada data roti"));
          }

          return GridView.builder(
            padding: EdgeInsets.all(10.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 4,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var roti = snapshot.data![index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(roti: roti),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(15.0)),
                          child: Image.network(
                            roti['gambar_url'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              roti['nama_roti'],
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              roti['deskripsi'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Row(
                              children: [
                                Icon(Icons.star,
                                    color: Colors.amber, size: 16.0),
                                Icon(Icons.star,
                                    color: Colors.amber, size: 16.0),
                                Icon(Icons.star,
                                    color: Colors.amber, size: 16.0),
                                Icon(Icons.star,
                                    color: Colors.amber, size: 16.0),
                                Icon(Icons.star_half,
                                    color: Colors.amber, size: 16.0),
                                Spacer(),
                                Text(
                                  'Rp ${roti['harga']}',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.brown,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
