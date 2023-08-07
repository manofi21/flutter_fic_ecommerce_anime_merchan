Start Up Strapi:
[ ] Buka DBeaver

[ ] Click Kanan DATABASES -> Pilih `Create New Database` -> Isikan database name
Contoh: new-ecommerce-database

[ ] Pindah ke path 
Contoh : cd D:\new_daily_april_2022\full_stack_flutter_practice && d:

[ ] Jalankan yarn create
Contoh: `yarn create strapi-app new-ecommerce-database`

[ ] Pilih `Custom` -> `JavaScript` -> `mysql` -> Enter 2x -> `root` -> Enter 2x

[ ] Karena ada error: Jalankan `cd D:\new_daily_april_2022\full_stack_flutter_practice\new-ecommerce-database && yarn install`

[ ] Jalankan `yarn develop`

[ ] Lakukan registrasi sampai masuk dashboard

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