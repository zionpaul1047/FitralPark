package fitralpark.nutrition.service;

import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.io.BufferedReader;
import java.io.IOException;

public class ApiExplorer {
    public static void main(String[] args) throws IOException {
        StringBuilder urlBuilder = new StringBuilder("http://api.data.go.kr/openapi/tn_pubr_public_nutri_food_info_api"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=yaSKDYRgmRNqJJExp%2BaxKTxEo%2FHVKZZTP0r8vZ2bNz%2BiAURxffMoDUq6HRu4YuCDb9XstHtC%2F8K1Ool2NM8rNA%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지 번호*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("100", "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("type","UTF-8") + "=" + URLEncoder.encode("xml", "UTF-8")); /*XML/JSON 여부*/
        urlBuilder.append("&" + URLEncoder.encode("foodCd","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*식품코드*/
        urlBuilder.append("&" + URLEncoder.encode("foodNm","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*식품명*/
        urlBuilder.append("&" + URLEncoder.encode("dataCd","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*데이터구분코드*/
        urlBuilder.append("&" + URLEncoder.encode("typeNm","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*데이터구분명*/
        urlBuilder.append("&" + URLEncoder.encode("foodOriginCd","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*식품기원코드*/
        urlBuilder.append("&" + URLEncoder.encode("foodOriginNm","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*식품기원명*/
        urlBuilder.append("&" + URLEncoder.encode("foodLv3Cd","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*식품대분류코드*/
        urlBuilder.append("&" + URLEncoder.encode("foodLv3Nm","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*식품대분류명*/
        urlBuilder.append("&" + URLEncoder.encode("foodLv4Cd","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*대표식품코드*/
        urlBuilder.append("&" + URLEncoder.encode("foodLv4Nm","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*대표식품명*/
        urlBuilder.append("&" + URLEncoder.encode("foodLv5Cd","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*식품중분류코드*/
        urlBuilder.append("&" + URLEncoder.encode("foodLv5Nm","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*식품중분류명*/
        urlBuilder.append("&" + URLEncoder.encode("foodLv6Cd","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*식품소분류코드*/
        urlBuilder.append("&" + URLEncoder.encode("foodLv6Nm","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*식품소분류명*/
        urlBuilder.append("&" + URLEncoder.encode("foodLv7Cd","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*식품세분류코드*/
        urlBuilder.append("&" + URLEncoder.encode("foodLv7Nm","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*식품세분류명*/
        urlBuilder.append("&" + URLEncoder.encode("nutConSrtrQua","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*영양성분함량기준량*/
        urlBuilder.append("&" + URLEncoder.encode("enerc","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*에너지(kcal)*/
        urlBuilder.append("&" + URLEncoder.encode("water","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*수분(g)*/
        urlBuilder.append("&" + URLEncoder.encode("prot","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*단백질(g)*/
        urlBuilder.append("&" + URLEncoder.encode("fatce","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*지방(g)*/
        urlBuilder.append("&" + URLEncoder.encode("ash","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*회분(g)*/
        urlBuilder.append("&" + URLEncoder.encode("chocdf","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*탄수화물(g)*/
        urlBuilder.append("&" + URLEncoder.encode("sugar","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*당류(g)*/
        urlBuilder.append("&" + URLEncoder.encode("fibtg","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*식이섬유(g)*/
        urlBuilder.append("&" + URLEncoder.encode("ca","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*칼슘(mg)*/
        urlBuilder.append("&" + URLEncoder.encode("fe","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*철(mg)*/
        urlBuilder.append("&" + URLEncoder.encode("p","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*인(mg)*/
        urlBuilder.append("&" + URLEncoder.encode("k","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*칼륨(mg)*/
        urlBuilder.append("&" + URLEncoder.encode("nat","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*나트륨(mg)*/
        urlBuilder.append("&" + URLEncoder.encode("vitaRae","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*비타민 A(μg RAE)*/
        urlBuilder.append("&" + URLEncoder.encode("retol","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*레티놀(μg)*/
        urlBuilder.append("&" + URLEncoder.encode("cartb","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*베타카로틴(μg)*/
        urlBuilder.append("&" + URLEncoder.encode("thia","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*티아민(mg)*/
        urlBuilder.append("&" + URLEncoder.encode("ribf","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*리보플라빈(mg)*/
        urlBuilder.append("&" + URLEncoder.encode("nia","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*니아신(mg)*/
        urlBuilder.append("&" + URLEncoder.encode("vitc","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*비타민 C(mg)*/
        urlBuilder.append("&" + URLEncoder.encode("vitd","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*비타민 D(μg)*/
        urlBuilder.append("&" + URLEncoder.encode("chole","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*콜레스테롤(mg)*/
        urlBuilder.append("&" + URLEncoder.encode("fasat","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*포화지방산(g)*/
        urlBuilder.append("&" + URLEncoder.encode("fatrn","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*트랜스지방산(g)*/
        urlBuilder.append("&" + URLEncoder.encode("srcCd","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*출처코드*/
        urlBuilder.append("&" + URLEncoder.encode("srcNm","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*출처명*/
        urlBuilder.append("&" + URLEncoder.encode("foodSize","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*식품중량*/
        urlBuilder.append("&" + URLEncoder.encode("restNm","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*업체명*/
        urlBuilder.append("&" + URLEncoder.encode("dataProdCd","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*데이터생성방법코드*/
        urlBuilder.append("&" + URLEncoder.encode("dataProdNm","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*데이터생성방법명*/
        urlBuilder.append("&" + URLEncoder.encode("crtYmd","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*데이터생성일자*/
        urlBuilder.append("&" + URLEncoder.encode("crtrYmd","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*데이터기준일자*/
        urlBuilder.append("&" + URLEncoder.encode("instt_code","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*제공기관코드*/
        urlBuilder.append("&" + URLEncoder.encode("instt_nm","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*제공기관기관명*/
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
        System.out.println(sb.toString());
    }
}