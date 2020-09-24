# Unit Testing Intro

## What

### What is unit test

A cheap, fast test method, tests the smallest part of your code, methods and classes. Some tests are covering functional algrithm, some are covering business logic.  

Essentially, a unit test is a method that instantiates a small portion of our application and verifies its behavior independently from other parts. A typical unit test contains 3 phases: First, it initializes a small piece of an application it wants to test (also known as the system under test, or SUT), then it applies some stimulus to the system under test (usually by calling a method on it), and finally, it observes the resulting behavior. If the observed behavior is consistent with the expectations, the unit test passes, otherwise, it fails, indicating that there is a problem somewhere in the system under test. These three unit test phases are also known as Arrange, Act and Assert, or simply AAA.

Imagine we want to build a LEGO vechile, it has four wheels, a electronic motor, a steering wheel can control the direction. Unit test focus on each smallest bricks works as expected, they behaves as we designed so. Let's say we need to test the motor, we put the power on(input), check the shaft begins to run(output).

A unit test is simulate the different inputs, check the output matches the result we expected, again, Arrange, Act and Assert.

### State or Interaction

A unit test can verify different behavioral aspects of the system under test, but most likely it will fall into one of the following two categories: state-based or interaction-based. Verifying that the system under test produces correct results, or that its resulting state is correct, is called state-based unit testing, while verifying that it properly invokes certain methods is called interaction-based unit testing.

#### state test

```csharp
public Decimal Add(Decimal x, Decimal y)
{
    return x + y;
}
```


#### interaction test

```csharp
public void Save(Entity entity)
{
    this.repository.Save(entity);
}
```

It is very important to test that the repository's Save method is being invoked with the correct input. Otherwise, some other developer could come along at a later date and delete that line of code and the regression test suite wouldn't alert you.

Remember: Simple things are not guaranteed to stay simple.

### Requirement testing and understanding

The essential part before sitting to write the unit tests is to review and "test" your requirements. Imagine that an algorithm is described in an Excel sheet with example data. You can use this one use case to write a test. However, there are many cases where the requirements can be wrong. Or this scenario is only one of the many examples that can occur. You should deeply understand what you need to test before you can design proper tests. This type of understanding beforehand helps to improve the design and code quality beforehand instead of using a reactive approach of fixing bugs after introducing them.

### What is NOT

#### Not finding bugs

Unit test is not finding bugs. They are written to verify algrithms, core business logics.

#### Not integration tests

The purpose of a unit test in software engineering is to verify the behavior of a relatively small piece of software, independently from other parts. Unit tests are narrow in scope, and allow us to cover all cases, ensuring that every single part works correctly.

On the other hand, integration tests demonstrate that different parts of a system work together in the real-life environment. They validate complex scenarios (we can think of integration tests as a user performing some high-level operation within our system), and usually require external resources, like databases or web servers, to be present.

Let's go back to LEGO vehicle, suppose all the parts successfully combined together, including the doors, wheels, steering. Now it's time to give it a try, making sure it can move on the floor, and steering works perfectly. First of all, we need to put it on a floor, switch on power, see whether it can moving forward or other directions. Then change the steering wheel a little bit, try it again. May be we also want to test what it will perform on a floor with sand, with grass or even water. In each test scienario, we record the result, clean it up, setup new environment.

All these activities are happens in a real or close-to-real envrionment, each part of the envrionment is real.

## Key Concepts

**SUT** System Under Test, the class that are under testing.

**Test Double** A generic term used for these objects. This word comes from 'stunt double'.

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

## Why

### Benifits

. A quick feedback of your code.

. A safe net for your application.

. A basic infrastructure for refactoring.

. A indicator for preveting code smell.

. A better way to improve code design.

. A documentation.

### Costs

. The time spent actually writing unit tests in the first place  
. The time spent fixing and updating unit tests, either because you’ve deliberately refactored interfaces between code units or the responsibilities distributed among them, or because tests broke unexpectedly when you made other changes  
. The tendency – either by you or your colleagues – to avoid improving and refactoring application code out of fear that it may break a load of unit tests and hence incur extra work  

## How

Not all codes need unit tests.

![image](http://blog.stevensanderson.com/wp-content/uploads/2009/11/image.png)

#### Do

##### AAA

#### Naming best practise

Avoid testcase01, testcase02, use senmatic method names, such as 'enabling_security_locks_windows_and_doors' or ''.


### DONTS
1. Test POCO
1. Test constructor or properties
1. Test private methods
1. Test multi-thread codes
1. comment out failed tests
1. touch real database, file system or other 3rd-party services.
1. Un-reliable results

One common reason make tests unreliable is doesn't arrange correctly, tests are rely on external environment or other classes, libaries.

#### Code hard to test

1. Anti-SRP
1. have invisible inputs or outputs

``` csharp

public static string GetTimeOfDay()
{
    DateTime time = DateTime.Now;
    if (time.Hour >= 0 && time.Hour < 6)
    {
        return "Night";
    }
    if (time.Hour >= 6 && time.Hour < 12)
    {
        return "Morning";
    }
    if (time.Hour >= 12 && time.Hour < 18)
    {
        return "Afternoon";
    }
    return "Evening";
}

```

It's hard to test because it has hidden input, `time`.

## Take Away

### 12 Benifits

- Unit tests prove that your code actually works
- You get a low-level regression-test suite
- You can improve the design without breaking it
- It's more fun to code with them than without
- They demonstrate concrete progress
- Unit tests are a form of sample code
- It forces you to plan before you code
- It reduces the cost of bugs
- It's even better than code inspections
- It virtually eliminates coder's block
- Unit tests make better designs
- It's faster than writing code without tests

### 5 Rules

1.Easy to understand (Typical test should take no longer than 15 seconds to read.)  
2.Test should fail only when there is a problem with production code.  
3.Tests should find all problems with production code.  
4.Tests should have as minimum duplication as possible.  
5.Should run quickly.  
 
## Refering

[Test Doubles — Fakes, Mocks and Stubs](https://blog.pragmatists.com/test-doubles-fakes-mocks-and-stubs-1a7491dfa3da) Michal Lipski  
[Test Double](https://martinfowler.com/bliki/TestDouble.html) Martin Fowler  
[Unit Tests, How to Write Testable Code and Why it Matters](https://www.toptal.com/qa/how-to-write-testable-code-and-why-it-matters) Sergey Kolodiy  
[TDD, Unit Tests and the Passage of Time](https://henrikwarne.com/2013/12/08/tdd-unit-tests-and-the-passage-of-time/) Henrik Warne  
[http://blog.stevensanderson.com/2009/11/04/selective-unit-testing-costs-and-benefits/](http://blog.stevensanderson.com/2009/11/04/selective-unit-testing-costs-and-benefits/)
