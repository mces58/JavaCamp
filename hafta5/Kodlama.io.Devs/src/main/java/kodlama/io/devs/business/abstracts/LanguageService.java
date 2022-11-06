package kodlama.io.devs.business.abstracts;

import java.util.List;

import kodlama.io.devs.business.requests.LanguageRequest;
import kodlama.io.devs.business.responses.LanguageResponse;
import kodlama.io.devs.entity.Language;

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
	
	// veriyi isme gore bul
	public Language findByName(String languageName);
}
