module contador::contador {
  use std::debug::print;

  public struct Counter has drop {
    current: u64,
    target: u64,
  }

  #[error]
  const ECOUNTER_OVERFLOW: u8 = 1;

  fun new(target: u64): Counter {
    Counter { current: 0, target: target }
  }

  fun increment(counter: &mut Counter){
    assert!(counter.current < counter.target, ECOUNTER_OVERFLOW);
    counter.current = counter.current + 1;
  }

  fun get_current(counter: &Counter): u64 {
    print(&counter.current);
    counter.current
  }

  fun is_completed(counter: &Counter): bool {
    counter.current == counter.target
  }

  fun reset(counter: &mut Counter) {
    counter.current = 0
  }

  fun play_counter(counter: &mut Counter): () {
    while (!is_completed(counter)) {
      get_current(counter);
      increment(counter);
    };
    reset(counter);
  }

  #[test]
  fun test_main(){
    let mut counter = new(10);
    play_counter(&mut counter)
  }
}