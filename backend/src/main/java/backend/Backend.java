package backend;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.beans.BeanInstantiationException;

@SpringBootApplication
@RestController
public class Backend {

    public static void main(String[] args) {
        SpringApplication.run(Backend.class, args);
    }

    @GetMapping("/api/hello")
    public String hello() {
        return "Hello, World!, coming from backend";
    }
}
