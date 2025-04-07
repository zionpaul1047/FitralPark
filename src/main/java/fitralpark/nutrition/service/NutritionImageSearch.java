package fitralpark.nutrition.service;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;

//(비즈니스 로직 서비스 클래스 자리)
public class NutritionImageSearch {
	
	public static void main(String[] args) {
		getFirstImageURL("감자");

	}
	
    public static String getFirstImageURL(String foodName) {
        
    	String searchURL = "" + foodName.replace(" ", "+");
    	String imageUrl = null;
    	
    	try {
            // 네이버 이미지 검색 페이지 요청
            Document document = Jsoup.connect(searchURL)
                    .userAgent("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36")
                    .get();
            
            System.out.println(document);
            
            // 첫 번째 이미지 태그 찾기
            Element firstImageElement = document.select("a.gs-image gs-image-scalable > img").first();
            if (firstImageElement != null) {
                imageUrl = firstImageElement.attr("src"); // 이미지 URL 추출
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    		System.out.println(imageUrl);
        return imageUrl; // 첫 번째 이미지 URL 반환
    }

}
