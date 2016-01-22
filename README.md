# xunit-xml2junit
Converts an xunit xml to a junit xml that can be consumed in jenkins

## Usage
``` shell
ruby xunit-xml2junit.rb input.xml > output.xml
```

## Expected input format
As generated from the xml reporter included in dnx xunit runner.
``` xml
<?xml version="1.0" encoding="utf-8"?>
<assemblies>
  <assembly name="dll" environment="64-bit .NET (unknown version) [collection-per-class, parallel (4 threads)]" test-framework="xUnit.net 2.1.0.3179" run-date="2016-01-21" run-time="16:12:30" total="18" passed="18" failed="0" skipped="0" time="0.210" errors="0">
    <errors />
    <collection total="6" passed="6" failed="0" skipped="0" name="Test collection for MemoryComponentStoreShould" time="0.026">
      <test name="MemoryComponentStoreShould.ReturnComponentsOfAGivenAppType" type="MemoryComponentStoreShould" method="ReturnComponentsOfAGivenAppType" time="0.0182538" result="Pass" />
      <test name="MemoryComponentStoreShould.FindAComponentByGuid" type="MemoryComponentStoreShould" method="FindAComponentByGuid" time="0.002073" result="Pass" />
    </collection>
  </assembly>
</assemblies>
```

## JUnit output format
Here follows a short example on how the JUNit file will be generated. This format is written with the intent to be fully compatible with Jenkins/Hudson.
``` xml
<testsuite tests="3">
    <testcase classname="foo1" name="ASuccessfulTest"/>
    <testcase classname="foo2" name="AnotherSuccessfulTest"/>
    <testcase classname="foo3" name="AFailingTest">
        <failure type="NotEnoughFoo"> details about failure </failure>
    </testcase>
</testsuite>
```
