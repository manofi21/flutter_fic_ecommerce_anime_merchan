# Start Up Strapi:
[ ] Buka DBeaver

[ ] Click Kanan DATABASES -> Pilih `Create New Database` -> Isikan database name
Contoh: new-ecommerce-database

[ ] Pindah ke path 
Contoh : cd D:\new_daily_april_2022\full_stack_flutter_practice && d:

[ ] Jalankan yarn create
Contoh: `yarn create strapi-app new-ecommerce-database`

[ ] Pilih `Custom` -> `JavaScript` -> `mysql` -> Enter 2x -> `root` -> Enter 2x

[ ] Karena ada error: Jalankan `cd D:\new_daily_april_2022\full_stack_flutter_practice\new-ecommerce-database && yarn install`

[ ] Jalankan `yarn develop` (atau `d: && cd D:\new_daily_april_2022\full_stack_flutter_practice\new-ecommerce-database && yarn develop`)

[ ] Lakukan registrasi sampai masuk dashboard

### Imput table dan mengisi table static (SubItemType, SourceItem, ItemType)

-------------------------------------------------------

[ ] click `Content-Type Builder` dan click  `Create new collection type` dan isi Design table seperti berikut:
1. ItemType 
Column => item_type | Text

2. Order
    Column: 1. items | JSON
            2. total_price | Number
            3. delivery_address | Text
            4. courier_name | Text
            5. shipping_cost | Number
            6. order_status  | Enum (waitingPayment, purchased, onDelivery, delivered, cancel)

3. PaymentCallback 
    Column: 1. history | JSON

4. Product
    Column: 1. product_name | text
            2. description | Rich text
            3. quantity | Number
            4. price | Number 
            5. in_stock | Boolean
            6. distributor | Text
            7. images | Media
            8. sub_item_type | Relation with SubItemType (Product has one ) 
            9. source_item | Relation with SourceItem (Product has many)

5. SourceItem
    Column: 1. source_item | text

6. SubItemType
    Column: 1. item_type | Relation with ItemType (SubItemType has one)
            2. sub_item_type | Text 

[ ] Isi beberapa table dengan data berikut

ItemType: Book, Cassette, Display, Other

SourceItem : Anime/Cartoon, Manga/Comic, Games, Light Novel, Vtuber

SubItemType : 
 Acrylic
Display

Action Figure
Display 

 Album(Music)
Cassette 

 Artwork
Book 

 Cartridge
Other 

 Cosplay clothes
Other 

 DVD
Cassette 

 Graphic Novel/American Comic
Book 

 Komik Fanart
Book 

 Komik Local
Book 

 Light Novel
Book 

 Manga Japan
Book 

 Manhua(China)
Book 

 Manwha(Korea)
Book 

 Model KIT
Display 

 Mouse Pad
Other 

 Pin
Other 

 ROM
Cassette 

 Statue
Display 

 VCD
Cassette 

 Post Card
Other 

### Install Ngrok untuk melakukan public localhost melalui device 

------------------------------------

~~[ ] Install Nginx dari [Link ini](https://nginx.org/en/docs/windows.html)~~

[ ] Install Ngrok dari [Link ini](https://ngrok.com/) 

[ ] Ikuti tutorial installasi melalui [Link ini](https://medium.com/@skzulka/cara-install-ngrok-di-windows-b9b32855f38e?source=list-ff7f780fed4e--------6-------predefined%3Aff7f780fed4e%3AREADING_LIST---------------------)

[ ] Setelah sudah, jalankan `ngrok http 1337`

---------------------------------------------

### Menambahkan Permission untuk bisa mengakses file dari Starpi

[ ] Kembali ke [dashboard strapi](http://localhost:1337)

[ ] Click `setting` dibagian kiri.

[ ] Pilih `Roles` pada `USERS & PERMISSIONS PLUGIN`

[ ] Pilih `Authenticated` dan di bagian `Permissions` pilih `Product`

[ ] Centang pada `find` dan `findOne` lalu save

[ ] Lakukan juga di `SourceItem`, `ItemType`,`SubItemType`, 

### Buat akun mitrands

[ ] Regis dengan [Mintrands registration](https://dashboard.midtrans.com/register)

[ ] Isikan: 
- Bussiness Name ()
- Full Name (MM Arial)
- Bussiness email untuk regist buatstrapimitrands@gmail.com
- Bussiness Phone Number (Yang belum di registrasi sama sekali di mitrands)

[ ] Setelah sign up akan berpindah ke login page. Kembali ke gmail untuk melakukan konfirmasi email

[ ] Lakukan login dan dari Environtment pindah ke SandBox

[ ] Pindah ke [Halaman Access Key](https://dashboard.sandbox.midtrans.com/settings/config_info)

### Integrasi Strapi dan Mitrands

[ ] jalankan `npm install --save midtrans-client` di Directory strapi dan tunggu

[ ] Pindah ke src/api/order/controller/order.js dan isi seperti berikut:
```javascript

module.exports = createCoreController('api::order.order', ({ strapi }) => ({
    async create(ctx) {
        const midtransClient = require('midtrans-client');
        let serverKey ='-';
        let clienKey = '--';
        const result = await super.create(ctx);
        
        // Function jika menggunakan mitrans Snap
        // let response = await midtransSnapFunction(serverKey, clienKey, midtransClient, result);

        // Function jika menggunakan mitrans Core
        let response = midtransCoreFunction(serverKey, clienKey, midtransClient, result);
    
        return response;
    }
}));

// Function untuk memanggil result menggunakan midtrans Snap
async function midtransSnapFunction(serverKey, clienKey, midtransClient, result) {

    // Create Snap API instance
    let snap = new midtransClient.Snap({
            isProduction : false,
            serverKey : serverKey,
            clientKey : clienKey
        });
    
    let parameter = {
        "transaction_details": {
            "order_id": result.data.id,
            "gross_amount": result.data.attributes.totalPrice,
        }, "credit_card":{
            "secure" : true
        }
    };
    
    return snap.createTransaction(parameter);
}

// Function untuk memanggil result menggunakan midtrans Snap
async function midtransCoreFunction(serverKey, clienKey, midtransClient, result) {
    // Create Core API instance
    let core = new midtransClient.CoreApi({
        isProduction : false,
        serverKey : serverKey,
        clientKey : clienKey
    });

    let parameter = {
        "payment_type": "gopay",
        "transaction_details": {
            "order_id": result.data.id,
            "gross_amount": result.data.attributes.totalPrice,
        },
        "credit_card":{
            "token_id": 'CREDIT_CARD_TOKEN', // change with your card token
            "authentication": true
        }
    };

    // charge transaction
    return core.charge(parameter);
}
```

[ ] Jangan lupa untuk mengganti serverKey, dan clienKey sesuai midtrands

[ ] Setelah itu jalankan `yarn install` untuk memunculkan midtrands di lockfile

[ ] Kembali ke Dashboard

[ ] Click `setting` dibagian kiri.

[ ] Pilih `Roles` pada `USERS & PERMISSIONS PLUGIN`

[ ] Pilih `Authenticated` dan di bagian `Permissions` pilih `Order`

[ ] Centang pada `Create` dan save