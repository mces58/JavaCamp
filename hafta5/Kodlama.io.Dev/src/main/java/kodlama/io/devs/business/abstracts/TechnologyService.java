package kodlama.io.devs.business.abstracts;

import java.util.List;

import kodlama.io.devs.business.request.TechnologyRequest;
import kodlama.io.devs.business.response.TechnologyResponse;

public interface TechnologyService {
	// hepsini getir
	public List<TechnologyResponse> findAll();

	// id degerine gore getir
	public TechnologyResponse findById(int id);

	// veriyi kaydet, geri donder
	public TechnologyResponse save(TechnologyRequest request);

	// veriyi guncelle, geri donder
	public TechnologyResponse update(int id, TechnologyRequest request);

	// veriyi sil, geri donder
	public TechnologyResponse deleteById(int id);
}
