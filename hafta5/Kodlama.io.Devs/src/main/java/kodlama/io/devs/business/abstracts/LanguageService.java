package kodlama.io.devs.business.abstracts;

import java.util.List;

import kodlama.io.devs.business.request.LanguageRequest;
import kodlama.io.devs.business.response.LanguageResponse;

public interface LanguageService {
	public List<LanguageResponse> findAll();

	public LanguageResponse findAllById(int id);

	public void save(LanguageRequest languageRequest);

	public void update(int id, LanguageRequest languageRequest);

	public void deleteById(int id);
}
