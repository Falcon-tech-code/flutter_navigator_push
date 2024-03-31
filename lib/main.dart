import 'package:flutter/material.dart';
 
void main() => runApp(const MyApp());
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => const GirisEkrani(),
        "/ProfilSayfasiRotasi": (context) => const ProfilEkrani(),
      },
    );
  }
}
 
class GirisEkrani extends StatefulWidget {
  const GirisEkrani({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GirisEkraniState createState() => _GirisEkraniState();
}
 
class _GirisEkraniState extends State<GirisEkrani> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
 
  girisYap() {
    if (t1.text == "admin" && t2.text == "1234") {
      Navigator.pushNamed(
        context,
        "/ProfilSayfasiRotasi",
        arguments: VeriModeli(kullaniciAdi: t1.text, sifre: t2.text),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Yanlış kullanıcı adı veya şifre"), // 'new' kelimesi gereksiz ve eski Dart sürümlerinden kalma. Artık kullanılmıyor.
            content: const Text("Lütfen giriş bilgilerinizi gözden geçirin."), // 'const' kullanımı performans için önerilir fakat şart değil.
            actions: <Widget>[
              // 'FlatButton' kullanımı eskidi, 'TextButton' kullanılmalı.
              TextButton(
                child: const Text("Kapat"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Giriş Ekrani")),
      body: Container(
        margin: const EdgeInsets.all(100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(hintText: "Kullanıcı Adı"),
              controller: t1,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: "Şifre"),
              controller: t2,
            ),
            // 'RaisedButton' yerine 'ElevatedButton' kullanılmalıdır.
            ElevatedButton(
              onPressed: () {
                girisYap();
              },
              child: const Text("Giriş Yap")
            ),
          ],
        ),
      ),
    );
  }
}
 
class ProfilEkrani extends StatefulWidget {
  const ProfilEkrani({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilEkraniState createState() => _ProfilEkraniState();
}
 
class _ProfilEkraniState extends State<ProfilEkrani> {
  cikisYap() {
    Navigator.pop(context);
  }
 
  @override
  Widget build(BuildContext context) {
    final VeriModeli iletilenArgumanlar = ModalRoute.of(context)!.settings.arguments as VeriModeli; // '!' ve 'as' kullanımı ile null ve tip kontrolü sağlandı.
    return Scaffold(
      body: Column(
        children: <Widget>[
          // 'RaisedButton' yerine 'ElevatedButton' kullanılmalıdır.
          ElevatedButton(
            onPressed: cikisYap,
            child: const Text("Çıkış Yap"),
          ),
          Text("Kullanıcı Adınız: ${iletilenArgumanlar.kullaniciAdi}"),
          Text("Şifreniz: ${iletilenArgumanlar.sifre}"),
        ],
      ),
    );
  }
}
 
class VeriModeli {
  String kullaniciAdi, sifre;
  // Parametreler null olamaz, bu yüzden 'required' ekleyerek bunların zorunlu olduğunu belirtiyoruz.
  VeriModeli({required this.kullaniciAdi, required this.sifre});
}

/*
Bu kodda iki ana ekran bulunuyor: 
'GirisEkrani' ve 'ProfilEkrani'
'GirisEkrani' kullanıcının giriş bilgilerini girerek oturum açmasını sağlar. 
Eğer bilgiler doğruysa, kullanıcı `ProfilEkrani`'na yönlendirilir. 
Bu ekran üzerinde kullanıcı adı ve şifre bilgileri görüntülenir. 
Yanlış bilgi girilirse, kullanıcıya bir hata mesajı gösterilir.*/
