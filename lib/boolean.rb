class TrueClass
  # Return true after yielding to the block to be performed when the receiver is true.
  def ifTrue
    yield
    self
  end

  # Return true without performing any block, since the receiver is true
  def ifFalse
    self
  end
end

class FalseClass
  # Return false without performing any block, since the receiver is false
  def ifTrue
    self
  end

  # Return false after yielding to the block to be performed when the receiver is false.
  def ifFalse
    yield
    self
  end
end