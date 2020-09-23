# Unit Testing Intro

## What

A cheap, fast test method, tests the smallest part of your code, methods and classes. Some tests are covering functional algrithm, some are covering business logic.  
Unit tests are also automatic regression testing tools.

### Do

Write unit tests as early as possible, and targets to TDD, that is write test first, then make it pass, follow the YELLO-RED-GREEN cycle.

### Don't

### Concepts

**SUT** System Under Test, the class that are under testing.

**Mock** Used for verifying "indirect output" of the tested code, by first defining the expectations before the tested code is executed. Usually used in 'command' methods.  A mock is similar to a stub, but with verification added in. The purpose of a mock is to make assertions about how your system under test interacted with the dependency.

``` java

public class SecurityCentral {
    private final Window window;
    private final Door door;

    public SecurityCentral(Window window, Door door) {
        this.window = window;
        this.door = door;
    }

    void securityOn() {
        window.close();
        door.close();
    }
}

public class SecurityCentralTest {
    Window windowMock = mock(Window.class);
    Door doorMock = mock(Door.class);

    @Test
    public void enabling_security_locks_windows_and_doors() {
        SecurityCentral sut = new SecurityCentral(windowMock, doorMock);
        sut.securityOn();
        verify(doorMock).close();
        verify(windowMock).close();
    }
}

```

**Fake** Used as a simpler implementation, e.g. using an in-memory database in the tests instead of doing real database access.

``` java
@Profile("transient")
public class FakeAccountRepository implements AccountRepository {
       
       Map<User, Account> accounts = new HashMap<>();
       
       public FakeAccountRepository() {
              this.accounts.put(new User("john@bmail.com"), new UserAccount());
              this.accounts.put(new User("boby@bmail.com"), new AdminAccount());
       }
       
       String getPasswordHash(User user) {
              return accounts.get(user).getPasswordHash();
       }
}
```

**Stub** Like a mock class, except that it doesn't provide the ability to verify that methods have been called/not called. Usually used in 'query' methods.

``` java
class CreditoCheck { 

  boolean temDivida() {
    return valorDivida > 0.0;
  }
```

``` java

public class GradesServiceTest {
    private Student student;
    private Gradebook gradebook;

    @Before
    public void setUp() throws Exception {
        gradebook = mock(Gradebook.class);
        student = new Student();
    }

    @Test
    public void calculates_grades_average_for_student() {
        when(gradebook.gradesFor(student)).thenReturn(grades(8, 6, 10)); //stubbing gradebook
        double averageGrades = new GradesService(gradebook).averageGrades(student);
        assertThat(averageGrades).isEqualTo(8.0);
    }
}

```

**Dummy** Used when a parameter is needed for the tested method but without actually needing to use the parameter.

``` java
// A test driver program for the Book class
public class TestBook {
   public static void main(String[] args) {
      Author teck = new Author("Tan Ah Teck", "teck@somewhere.com", 'm');
      System.out.println(teck);  // toString()
 
      Book dummyBook = new Book("Java for dummies", teck, 9.99, 88);
      System.out.println(dummyBook);  // toString()
 
      Book moreDummyBook = new Book("Java for more dummies",
            new Author("Peter Lee", "peter@nowhere.com", 'm'),  // anonymous instance of Author
            19.99, 8);
      System.out.println(moreDummyBook);  // toString()
   }
}
```

**Test Double** A generic term used for these objects. This word comes from 'stunt double'.

## Why

. A quick feedback of your code.

. A safe net for your application.

. A basic infrastructure for refactoring.

. A indicator for preveting code smell.

. A better way to improve code design.

. A documentation.

### Costs

## How

#### 3-A process

Arrange-Act-Assert, also known as setup, execise, verify and teardown.

#### Naming best practise

Avoid testcase01, testcase02, use senmatic method names, such as 'enabling_security_locks_windows_and_doors' or ''.

``` java
public class OrderStateTester extends TestCase {
  private static String TALISKER = "Talisker";
  private static String HIGHLAND_PARK = "Highland Park";
  private Warehouse warehouse = new WarehouseImpl();

  protected void setUp() throws Exception {
    warehouse.add(TALISKER, 50);
    warehouse.add(HIGHLAND_PARK, 25);
  }
  public void testOrderIsFilledIfEnoughInWarehouse() {
    Order order = new Order(TALISKER, 50);
    order.fill(warehouse);
    assertTrue(order.isFilled());
    assertEquals(0, warehouse.getInventory(TALISKER));
  }
  public void testOrderDoesNotRemoveIfNotEnough() {
    Order order = new Order(TALISKER, 51);
    order.fill(warehouse);
    assertFalse(order.isFilled());
    assertEquals(50, warehouse.getInventory(TALISKER));
  }
  ```

#### Unit Testing Rules

. Each tests are isolated.
. Test classes names are end with 'test'.
. Test method names are started with 'test'.

#### When to write and run

Write before code merged, run with each commit.

#### Testable Code

##### Single Responsibilty Principle 

Unit of code does only one thing, and do it well. All the tests around it are making sure it does one thing well.  

Mixed code are hard to test, such as inaccessable the outputs, inputs are came from properties, not parameters.(anti specification programming).  

How to dealing with these codes, basic intruction is separate, separate the concerns by moving codes, such as new methods, classes, and functions, use IDE supported functions is an more easier way.

##### TDD

Keeps you focus, produces testable designs, help produce interface clear and help produce clean code.

# Refering

[Test Doubles — Fakes, Mocks and Stubs](https://blog.pragmatists.com/test-doubles-fakes-mocks-and-stubs-1a7491dfa3da) Michal Lipski
[Test Double](https://martinfowler.com/bliki/TestDouble.html) Martin Fowler
