package main.scadable.livequery;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Tag(name = "Hello")
public class HelloController {

  @Operation(summary = "Returns a friendly greeting")
  @ApiResponses({@ApiResponse(responseCode = "200", description = "Greeting returned")})
  @GetMapping("/hello")
  public String hello() {
    return "Hello World";
  }
}
