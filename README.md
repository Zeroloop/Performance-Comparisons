Language Performance Tests
================================

This repo exists as a method of comparing different languages web performance.

Any depencies should be referenced in the test files.

Contributions welcome.

// Python 2.7.5
- Fibonacci Numbers 0.19979 milliseconds
- 1,000,000         62.2270 milliseconds
- Count String      0.00619 milliseconds
- JSON              0.19192 milliseconds
- MySQL             5.81694 milliseconds
- SQLAlchemy        17.1700 milliseconds

// Python 3.4: via Pyramid time_all() 
- Fibonacci Numbers 0.16617 milliseconds
- 1,000,000         64.8890 milliseconds
- Count String      0.00596 milliseconds
- JSON              0.12803 milliseconds
- MySQL             5.94687 milliseconds
- SQLAlchemy        9.26709 milliseconds

// Lasso 9: http://localhost/lasso9.lasso
- Fibonacci Numbers 0.178000 milliseconds
- 1,000,000         55.75600 milliseconds
- Count String      0.011000 milliseconds
- JSON              10.18500 milliseconds
- MySQL Inline      4.258000 milliseconds
- MySQL DS          1.873000 milliseconds

