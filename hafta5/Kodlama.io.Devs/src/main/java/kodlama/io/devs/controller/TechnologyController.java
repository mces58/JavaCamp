package kodlama.io.devs.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kodlama.io.devs.business.abstracts.TechnologyService;
import kodlama.io.devs.business.request.TechnologyRequest;
import kodlama.io.devs.business.response.TechnologyResponse;

@RestController
@RequestMapping(value = "/api/technologies")
public class TechnologyController {
	private TechnologyService technologyService;

	@Autowired
	public TechnologyController(TechnologyService technologyService) {
		this.technologyService = technologyService;
	}

	@GetMapping("/")
	public List<TechnologyResponse> findAll() {
		return technologyService.findAll();
	}

	@PostMapping("/")
	public void add(@RequestBody TechnologyRequest technologyRequest) {
		technologyService.save(technologyRequest);
	}

	@PutMapping("/{id}")
	public void update(@PathVariable int id, @RequestBody TechnologyRequest technologyRequest) {
		technologyService.update(id, technologyRequest);
	}

	@DeleteMapping("/{id}")
	public void delete(@PathVariable int id) {
		technologyService.delete(id);
	}
}
