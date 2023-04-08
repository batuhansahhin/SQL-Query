-- Aşağıdaki senaryolarını dvdrental örnek veri tabanı üzerinden istenilen sorgularıdır
-- film tablosunda bulunan replacement_cost sütununda bulunan birbirinden farklı değerleri sıralayınız.
-- film tablosunda bulunan replacement_cost sütununda birbirinden farklı kaç tane veri vardır?
-- film tablosunda bulunan film isimlerinde (title) kaç tanesini T karakteri ile başlar ve aynı zamanda rating 'G' ye eşittir?
-- country tablosunda bulunan ülke isimlerinden (country) kaç tanesi 5 karakterden oluşmaktadır?
-- city tablosundaki şehir isimlerinin kaç tanesi 'R' veya r karakteri ile biter?

SELECT DISTINCT replacement_cost FROM film ORDER BY replacement_cost;
SELECT DISTINCT replacement_cost FROM film ORDER BY replacement_cost;
SELECT COUNT(*) FROM film WHERE title LIKE 'T%' AND rating = 'G';
SELECT COUNT(*) FROM country WHERE LENGTH(country) = 5;
SELECT COUNT(*) FROM country WHERE LENGTH(country) = 5;


-- Aşağıdaki senaryolarını dvdrental örnek veri tabanı üzerinden istenilen sorgularıdır
-- film tablosunda bulunan filmleri rating değerlerine göre gruplayınız.
-- film tablosunda bulunan filmleri replacement_cost sütununa göre grupladığımızda film sayısı 50 den fazla olan replacement_cost değerini ve karşılık gelen film sayısını sıralayınız.
-- customer tablosunda bulunan store_id değerlerine karşılık gelen müşteri sayılarını nelerdir?
-- city tablosunda bulunan şehir verilerini country_id sütununa göre gruplandırdıktan sonra en fazla şehir sayısı barındıran country_id bilgisini ve şehir sayısını paylaşınız.

SELECT 
    f.rating, COUNT(*) as film_sayisi, 
    f.replacement_cost, COUNT(*) as yuksek_costlu_film_sayisi, 
    c.store_id, COUNT(*) as musteri_sayisi, 
    ct.country_id, COUNT(*) as sehir_sayisi 
FROM 
    film f 
    LEFT JOIN inventory i ON f.film_id = i.film_id 
    LEFT JOIN rental r ON i.inventory_id = r.inventory_id 
    LEFT JOIN customer c ON r.customer_id = c.customer_id 
    LEFT JOIN address a ON c.address_id = a.address_id 
    LEFT JOIN city ct ON a.city_id = ct.city_id 
GROUP BY 
    f.rating, 
    f.replacement_cost, 
    c.store_id, 
    ct.country_id 
HAVING 
    COUNT(*) > 50 
ORDER BY 
    yuksek_costlu_film_sayisi DESC, 
    sehir_sayisi DESC;
