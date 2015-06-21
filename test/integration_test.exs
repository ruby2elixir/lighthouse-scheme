defmodule IntegrationTest do
  use ExUnit.Case

  test "ands" do
    Scheme.DefinitionTable.start_link

    Scheme.eval """
    ;; another comment
    (define member?
      (lambda (a lat)
        (cond
          ((null? lat) #f)
          ((eq? (car lat) a)
            #t)
          (else
            (member? a (cdr lat))))))

    ;; some comment
    (define is-rock-band?
      (lambda (band-name)
        (and (member? (quote a) band-name)
             (member? (quote c) band-name)
             (member? (quote d) band-name))))
    """

   assert Scheme.eval("(is-rock-band? (quote (a c d c)))") == "#t"
   assert Scheme.eval("(is-rock-band? (quote (a b b a)))") == "#f"
  end

  test "ors" do
    Scheme.DefinitionTable.start_link

    Scheme.eval """
    ;; some comment
    (define member?
      (lambda (a lat)
        (cond
          ((null? lat) #f)
          ((eq? (car lat) a)
            #t)
          (else
            (member? a (cdr lat))))))

    ;; yet another comment
    (define has-cool-resume?
      (lambda (resume) ;; some in-line comment
        (or (member? (quote elixir) resume)
            (member? (quote ocaml) resume)
            (member? (quote scheme) resume))))
    """

    assert Scheme.eval("(has-cool-resume? (quote (java javascript ocaml ruby)))") == "#t"
    assert Scheme.eval("(has-cool-resume? (quote (tps-reports synergy)))") == "#f"
  end

  test "nots" do
    Scheme.DefinitionTable.start_link

    Scheme.eval """
    (define is-not-elephant?
      (lambda (x)
        (not (eq? x (quote elephant)))))
    """

    assert Scheme.eval("(is-not-elephant? (quote elephant))") == "#f"
    assert Scheme.eval("(is-not-elephant? (quote laptop))") == "#t"
  end
end