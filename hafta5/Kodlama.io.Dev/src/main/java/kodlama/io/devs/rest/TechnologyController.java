package kodlama.io.devs.rest;

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
@RequestMapping(value = "/api")
public class TechnologyController {
	private TechnologyService service;

	@Autowired
	public TechnologyController(TechnologyService service) {
		this.service = service;
	}

	@GetMapping(value = "/technologies")
	public List<TechnologyResponse> findAll() {
		return this.service.findAll();
	}

	@GetMapping(value = "/technologies/{id}")
	public TechnologyResponse findById(@PathVariable int id) {
		return this.service.findById(id);

	}

	@PostMapping(value = "/technologies")
	public TechnologyResponse save(@RequestBody TechnologyRequest request) {
		return this.service.save(request);
	}

	@PutMapping(value = "/technologies/{id}")
	public TechnologyResponse update(@PathVariable int id, @RequestBody TechnologyRequest request) {
		return this.service.update(id, request);
	}

	@DeleteMapping(value = "/technologies/{id}")
	public TechnologyResponse deleteById(@PathVariable int id) {
		return this.service.deleteById(id);
	}
}
