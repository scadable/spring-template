package main.scadable.livequery;

import org.junit.jupiter.api.Test;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.ConfigurableApplicationContext;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;

@SpringBootTest
class LiveQueryApplicationTests
{

    @Test
    void contextLoads()
    {
    }

    @Test
    void applicationStartsViaMain()
    {
        assertDoesNotThrow(() ->
        {
            try (ConfigurableApplicationContext ctx =
                         SpringApplication.run(
                                 LiveQueryApplication.class,
                                 // ➊ no embedded web-server
                                 "--spring.main.web-application-type=none",
                                 // ➋ if some bean *does* start a web server,
                                 //    force an ephemeral port
                                 "--server.port=0"))
            {
                // started & closed normally
            }
        });
    }


}
