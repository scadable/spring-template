package main.scadable.livequery;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.mockStatic;

import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.springframework.boot.SpringApplication;
import org.springframework.context.ConfigurableApplicationContext;

class LiveQueryApplicationMainTest {

  @Test
  void mainDelegatesToSpringRun() {
    ConfigurableApplicationContext dummyCtx = mock(ConfigurableApplicationContext.class);

    try (MockedStatic<SpringApplication> spring = mockStatic(SpringApplication.class)) {
      spring
          .when(() -> SpringApplication.run(LiveQueryApplication.class, new String[] {}))
          .thenReturn(dummyCtx);

      // Executes every byte-code instruction in main()
      LiveQueryApplication.main(new String[] {});

      // verify via MockedStatic instance
      spring.verify(() -> SpringApplication.run(LiveQueryApplication.class, new String[] {}));
    }
  }
}
