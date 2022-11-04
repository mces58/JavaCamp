package kodlama.io.devs.business.abstracts;

import java.util.List;

import kodlama.io.devs.business.request.TechnologyRequest;
import kodlama.io.devs.business.response.TechnologyResponse;

public interface TechnologyService {
	public List<TechnologyResponse> findAll();

	public TechnologyResponse findAllById(int id);

	public void save(TechnologyRequest technologyRequest);

	public void update(int id, TechnologyRequest technologyRequest);

	public void delete(int id);
}
