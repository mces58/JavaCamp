package kodlama.io.devs.business.abstracts;

import java.util.List;

import kodlama.io.devs.business.request.LanguageRequest;
import kodlama.io.devs.business.response.LanguageResponse;
import kodlama.io.devs.entities.Language;

public interface LanguageService {
	// hepsini getir
	public List<LanguageResponse> findAll();

	// id degerine gore getir
	public LanguageResponse findById(int id);

	// veriyi kaydet, kaydedilen veriyi geri donder
	public LanguageResponse save(LanguageRequest request);

	// veriyi guncelle, guncellenen veriyi geri donder
	public LanguageResponse update(int id, LanguageRequest request);

	// veriyi sil, silinen veriyi geri donder
	public LanguageResponse deleteById(int id);

	public Language findByName(String languageName);
}
