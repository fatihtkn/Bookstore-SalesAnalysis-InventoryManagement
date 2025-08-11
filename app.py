from flask import Flask, request, jsonify,render_template,redirect,url_for,request
import mysql.connector
import base64
import pandas as pd
import random
import datetime
app = Flask(__name__)

conn = mysql.connector.connect(
    host="localhost",
    user="root",        
    password="",            
    database="zeus"   
)
cursor = conn.cursor()

kullaniciAd='admin'
sifre='admin'


@app.route('/')
def home():
     return render_template('login.html')


@app.route("/login", methods=['GET','POST'])
def login():

    data = request.get_json()
    userId = data.get('userId')
    userPassword = data.get('userPassword')
  
    
  
    if sifre == userPassword and kullaniciAd==userId:
      
        
        return jsonify({"success": True, "redirect_url": url_for('stockInfo')}), 200
       
    else:
        return jsonify({"success": False, "message": "Invalid Id and password"}), 401
           
   

@app.route('/homePage')
def homePage():
    return render_template('homePage.html')



@app.route('/salesByPlatform')
def salesByPlatform():
     return render_template('salesByPlatform.html')


@app.route('/stockInfo')
def stockInfo():
     return render_template('stockInformation.html')



@app.route('/salesByCategory')
def salesByCategory():
     return render_template('salesByCategory.html')



@app.route('/rent')
def rent():
    cursor = conn.cursor(dictionary=True)
    get_rentals_query = """
    SELECT 
        kitaplar.kitap_adi AS book_name,
        CONCAT(musteri.adi, ' ', musteri.soyadi) AS customer_name,
        kiralik.kiralama_tarihi AS rental_date,
        DATE_ADD(kiralama_tarihi, INTERVAL 15 DAY) AS due_date,
        CASE 
            WHEN DATE_ADD(kiralama_tarihi, INTERVAL 15 DAY) < NOW() THEN 'Hayır'
            ELSE 'Evet'
        END AS returned
    FROM 
        kiralik
    JOIN kitaplar ON kiralik.kitap_id = kitaplar.kitap_id
    JOIN musteri ON kiralik.musteri_id = musteri.musteri_id
    """
    cursor.execute(get_rentals_query)
    rentals = cursor.fetchall()
    return render_template('rental.html',rentals=rentals)


    




@app.route('/update_stock_info')
def update_stock_info():
    
    stockData=[]
    query="""SELECT 
    kitaplar.kitap_adi AS kitap_ad,
    CONCAT(yazarlar.adi, ' ', yazarlar.soyadi) AS yazar_ad,
    kitap_baski.stok AS stok_sayisi
    FROM 
    kitaplar
    JOIN 
    kitap_yazar ON kitaplar.kitap_id = kitap_yazar.kitap_id
    JOIN 
    yazarlar ON kitap_yazar.yazar_id = yazarlar.yazar_id
    JOIN 
    kitap_baski ON kitaplar.kitap_id = kitap_baski.kitap_id """
    cursor.execute(query)
    result=cursor.fetchall()
    
    for data in result:
        stockData.append({"name":data[0],"author":data[1],"stock":data[2]}) 


    return jsonify(stockData)


@app.route('/add_book', methods=['POST'])
def add_book():
    try:
    
        kitap_adi = request.form['kitap_adi']
        tarih = request.form['tarih']
        sayfa_sayisi = int(request.form['sayfa_sayisi'])
        stok = int(request.form['stok_sayisi'])
        yazar_id = int(request.form['author_id'])
        tur_id = int(request.form['genre_id'])
        year=tarih.split('-')[0]
        print("YIL= "+year)
        with conn.cursor() as cursor:
            
            sql_kitap_ekle = """
                INSERT INTO kitaplar (kitap_adi, basimevi_id, yili, sayfa_sayisi)
                VALUES (%s, %s, %s, %s)
            """
            cursor.execute(sql_kitap_ekle, (kitap_adi, 1, year, sayfa_sayisi))  
            kitap_id = cursor.lastrowid  

          
            sql_kitap_yazar_ekle = """
                INSERT INTO kitap_yazar (kitap_id, yazar_id)
                VALUES (%s, %s)
            """
            cursor.execute(sql_kitap_yazar_ekle, (kitap_id, yazar_id))
            
          
            sql_kitap_tur_ekle = """
                INSERT INTO kitap_tur (kitap_id, tur_id)
                VALUES (%s, %s)
            """
            cursor.execute(sql_kitap_tur_ekle, (kitap_id, tur_id))
            
           
            pbIdQ = """
                SELECT baski_id FROM baski WHERE baski_tarih = %s 
            """
          
            cursor.execute(pbIdQ, (tarih,))
            cursor.fetchall()
            editionId=0
           
            if cursor.rowcount<=0:
                
                editionQuery=""" INSERT INTO baski (baski_no,baski_tarih) VALUES(%s, %s ) """
                cursor.execute(editionQuery,(1,tarih))
                editionId=cursor.lastrowid
                
            else:
                editionId = cursor.fetchall()[0][0]
                

           
            if editionId is None:
                return jsonify({"error": "Baskı bilgisi bulunamadı!"}), 400
            
           
            sql_kitap_baski_ekle = """
                INSERT INTO kitap_baski (kitap_id, baski_id, stok)
                VALUES (%s, %s, %s)
            """
            cursor.execute(sql_kitap_baski_ekle, (kitap_id, editionId, stok))
          
            conn.commit()

        return jsonify({"message": "Kitap başarıyla eklendi!"}), 201

    except Exception as e:
        conn.rollback()  
        return jsonify({"error": str(e)}), 500

    
    
    
@app.route('/delete_book',methods=['POST'])
def delete_book():
    try:
       
        bookId=request.form['book_id']
        
       
        with conn.cursor() as cursor:
         
            bookQuery = """
                DELETE FROM kitaplar WHERE kitap_id = %s
            """
            cursor.execute(bookQuery, (bookId,))
            
         
            if cursor.rowcount == 0:
                return jsonify({"error": "Silinecek kitap bulunamadı!"}), 404
            
          
            conn.commit()

        return jsonify({"message": f"'{bookId}' başarıyla silindi!"}), 200
    except Exception as e:
        conn.rollback()
        return jsonify({"error": str(e)}), 500






@app.route('/get_sales_data', methods=['GET'])
def get_sales_data():
    
    cursor = conn.cursor(dictionary=True)

   
    query = """
    SELECT
        MONTHNAME(satislar.satis_tarihi) AS Ay,
        siteler.site_adi AS Platform,
        SUM(satislar.adet) AS Toplam_Satis
    FROM
        satislar
    JOIN
        siteler ON satislar.site_id = siteler.site_id
    WHERE
        MONTH(satislar.satis_tarihi) BETWEEN 1 AND 6
    GROUP BY
        MONTH(satislar.satis_tarihi), siteler.site_adi
    ORDER BY
        MONTH(satislar.satis_tarihi), siteler.site_adi;
    """
    cursor.execute(query)
    results = cursor.fetchall()

    
    months = ["January", "February", "March", "April", "May", "June"]
    platforms = {}
    for row in results:
        month = row['Ay']
       
        platform = row['Platform']
        total_sales = row['Toplam_Satis']

        if platform not in platforms:
            platforms[platform] = [0] * len(months) 

        month_index = months.index(month) 
        platforms[platform][month_index] = total_sales

 
    series = [{"name": platform, "data": sales} for platform, sales in platforms.items()]
    
    
    return jsonify({
        "categories": months,
        "series": series
    })
    
    



@app.route('/get_category_sales_data')
def get_category_sales_data():
    
   
    cursor = conn.cursor(dictionary=True)

    query = """
    SELECT 
        turler.tur_ad AS category_name,
        SUM(satislar.adet) AS sales_amount
    FROM 
        satislar
    JOIN 
        kitaplar ON satislar.kitap_id = kitaplar.kitap_id
    JOIN 
        kitap_tur ON kitaplar.kitap_id = kitap_tur.kitap_id
    JOIN 
        turler ON kitap_tur.tur_id = turler.tur_id
    GROUP BY 
        turler.tur_ad
    ORDER BY 
        sales_amount DESC;
    """
    cursor.execute(query)
    book_sales_data = cursor.fetchall()  

   
    data = {
        "categories": [item["category_name"] for item in book_sales_data],
        "series": [
            {
                "name": "Satış Rakamları",
                "data": [item["sales_amount"] for item in book_sales_data],
            }
        ],
    }

    

    return jsonify(data)






@app.route('/topBottomTenSellers')
def topBottomTenSellers():
    
    cursor = conn.cursor(dictionary=True)

 
    top_books_query = """
    SELECT 
        kitaplar.kitap_adi AS name,
        CONCAT(yazarlar.adi, ' ', yazarlar.soyadi) AS author,
        SUM(satislar.adet) AS sales
    FROM 
        satislar
    JOIN 
        kitaplar ON satislar.kitap_id = kitaplar.kitap_id
    JOIN 
        kitap_yazar ON kitaplar.kitap_id = kitap_yazar.kitap_id
    JOIN 
        yazarlar ON kitap_yazar.yazar_id = yazarlar.yazar_id
    GROUP BY 
        kitaplar.kitap_id
    ORDER BY 
        sales DESC
    LIMIT 10;
    """

   
    bottom_books_query = """
    SELECT 
        kitaplar.kitap_adi AS name,
        CONCAT(yazarlar.adi, ' ', yazarlar.soyadi) AS author,
        SUM(satislar.adet) AS sales
    FROM 
        satislar
    JOIN 
        kitaplar ON satislar.kitap_id = kitaplar.kitap_id
    JOIN 
        kitap_yazar ON kitaplar.kitap_id = kitap_yazar.kitap_id
    JOIN 
        yazarlar ON kitap_yazar.yazar_id = yazarlar.yazar_id
    GROUP BY 
        kitaplar.kitap_id
    ORDER BY 
        sales ASC
    LIMIT 10;
    """

   
    cursor.execute(top_books_query)
    top_10_books = cursor.fetchall()

    cursor.execute(bottom_books_query)
    bottom_10_books = cursor.fetchall()


    
    return render_template("topBottomTenSellers.html", top_10_books=top_10_books, bottom_10_books=bottom_10_books)







@app.route('/topAuthors')
def topAuthors():
    
   
    cursor = conn.cursor(dictionary=True)

   
    query = """
    SELECT 
        CONCAT(yazarlar.adi, ' ', yazarlar.soyadi) AS author,
        SUM(satislar.adet) AS count
    FROM 
        satislar
    JOIN 
        kitaplar ON satislar.kitap_id = kitaplar.kitap_id
    JOIN 
        kitap_yazar ON kitaplar.kitap_id = kitap_yazar.kitap_id
    JOIN 
        yazarlar ON kitap_yazar.yazar_id = yazarlar.yazar_id
    GROUP BY 
        yazarlar.yazar_id
    ORDER BY 
        count DESC
    LIMIT 10;
    """

    cursor.execute(query)
    top_10_authors = cursor.fetchall()


   
    return render_template("topAuthors.html", top_10_authors=top_10_authors)



#Kitap Kiralama

@app.route('/search/book', methods=['GET'])
def search_book():
    query = request.args.get('q', '')
   
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT kitap_id, kitap_adi,yili FROM kitaplar WHERE kitap_adi LIKE %s LIMIT 10", (f"%{query}%",))
    books = cursor.fetchall()
    return jsonify(books)



@app.route('/search/customer', methods=['GET'])
def search_customer():
    query = request.args.get('q', '')
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT musteri_id, CONCAT(adi, ' ', soyadi) AS name FROM musteri WHERE adi LIKE %s OR soyadi LIKE %s LIMIT 10", (f"%{query}%", f"%{query}%"))
    customers = cursor.fetchall()
    return jsonify(customers)



@app.route('/rental', methods=['GET', 'POST'])
def rental():
    
    cursor = conn.cursor(dictionary=True)
    
    if request.method == 'POST':

       
        customer_id = request.form.get('customer_id')
        book_id = request.form.get('book_id')
        rental_date = datetime.datetime.now()

        if not book_id or not customer_id:
            return jsonify({"message":"Kitap ve müşteri seçimi zorunludur."} ),400
        
       
        cursor.execute("SELECT kitap_baski.baski_id AS edition FROM kitap_baski WHERE kitap_baski.kitap_id=%s GROUP BY kitap_baski.kitap_id ", (book_id,))
        edition_id=cursor.fetchone()['edition']
      
        add_rental_query = """
        INSERT INTO kiralik (kitap_id, baski_id, musteri_id, kiralama_tarihi)
        VALUES (%s, %s, %s, %s)
        """
        cursor.execute(add_rental_query, (book_id, edition_id, customer_id, rental_date))
        conn.commit()
        return redirect(url_for('rental'))

   


    
    
    get_rentals_query = """
    SELECT 
        CONCAT(kitaplar.kitap_adi, '-', kitaplar.yili) AS book_name,
        CONCAT(musteri.adi, ' ', musteri.soyadi) AS customer_name,
        kiralik.kiralama_tarihi AS rental_date,
        DATE_ADD(kiralama_tarihi, INTERVAL 15 DAY) AS due_date,
        CASE 
            WHEN DATE_ADD(kiralama_tarihi, INTERVAL 15 DAY) < NOW() THEN 'Hayır'
            ELSE 'Evet'
        END AS returned
    FROM 
        kiralik
    JOIN kitaplar ON kiralik.kitap_id = kitaplar.kitap_id
    JOIN musteri ON kiralik.musteri_id = musteri.musteri_id
    """
    cursor.execute(get_rentals_query)
    rentals = cursor.fetchall()

    
    
    return render_template("rental.html", rentals=rentals)




@app.route('/search/author', methods=['GET'])
def search_author():
    query = request.args.get('q', '')
   
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT yazar_id as id, CONCAT(adi, ' ', soyadi) AS name FROM yazarlar WHERE adi LIKE %s OR soyadi LIKE %s LIMIT 10", (f"%{query}%", f"%{query}%"))
    books = cursor.fetchall()
    return jsonify(books)


@app.route('/search/genre', methods=['GET'])
def search_genre():
    query = request.args.get('q', '')
   
    cursor = conn.cursor(dictionary=True)
    
    cursor.execute("SELECT tur_id as id,tur_ad as name FROM turler WHERE tur_ad LIKE %s LIMIT 10", (f"%{query}%",))
    books = cursor.fetchall()
   
    return jsonify(books)




if __name__ == '__main__':
    app.run(debug=True)