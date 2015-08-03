require 'allocation_challenge'
require 'minitest/autorun'

class TestAllocationChallenge < Minitest::Test

  def new_account
    return Account.new(0001, 1000)
  end

  def new_allocation
    return Allocation.new("FOO", 25)
  end

  def new_asset
    Asset.new("FOO", 5)
  end

  def make_single_allocation
    $assets = [new_asset]
    test = new_account 
    test.allocations << new_allocation
    test.allocate
    return test
  end

  def test_asset
    test = new_asset
    assert_equal(test.name, "FOO")
    assert_equal(test.price, 5)
  end

  def test_account
    test = new_account
    assert_equal(test.id, 0001)
    assert_equal(test.cash, 1000)
    assert_empty(test.allocations)

    test.allocations << new_allocation

    refute_empty(test.allocations)
  end

  def test_allocation
    test = Allocation.new("FOO", 25)
    assert_equal(test.asset_name, "FOO")
    assert_equal(test.target, 25)
    assert_equal(test.purchased, 0)
  end

  def test_calculate_actual
    assert_equal(make_single_allocation.allocations.first.purchased, 200)
  end

  def test_optimized
    assert_equal(make_single_allocation.leftover, 0)
  end

  def test_amount_spent
    assert_equal(make_single_allocation.spent, 1000)
  end

end
