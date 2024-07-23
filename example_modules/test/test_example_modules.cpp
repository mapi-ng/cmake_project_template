#include <gtest/gtest.h>

import adder;

TEST(TestExampleModules, AdderOk) {
  EXPECT_EQ(5, add(2, 3));
}