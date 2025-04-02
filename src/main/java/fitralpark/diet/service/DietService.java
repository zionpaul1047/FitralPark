package fitralpark.diet.service;

import java.util.List;

import fitralpark.diet.dao.DietDAO;
import fitralpark.diet.dto.DietDTO;

//(비즈니스 로직 서비스 클래스 자리)
public class DietService {
    private final DietDAO dietDao = new DietDAO();

    public List<DietDTO> getFilteredDiets(String mealTime, int minCal, int maxCal, String searchTerm) {
        if (minCal < 0 || maxCal < 0 || minCal > maxCal) {
            throw new IllegalArgumentException("잘못된 열량 범위입니다.");
        }
        return dietDao.list(mealTime, minCal, maxCal, searchTerm);
    }
}

