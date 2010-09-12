package foo.bar;

import baz.bar.SomeOtherClass;

public class SomeClassWithADependancy
{  
    public static void main(String args[])
    {
        System.out.println("Hello from this class.");
        SomeOtherClass.sayHello();
    }
}
