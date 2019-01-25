defmodule PigLatin do
  @vowels ["a", "i", "o", "e", "u"]
  @vowel_exceptions ["yt", "xr", "xb"]

  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    # phrase_analysis = %{ "phrase" => phrase, "vowel" => begins_with_vowel?(phrase), "vowel_exception" => vowel_exception?(phrase)}
    # route_word(phrase_analysis)
    translate_word(phrase)

    # treat_as_vowel?(phrase)
  end

  defp translate_word(word) do
    if apply_vowel_translation do
      translates_vowels(word)
    end
  end

  defp apply_vowel_translation(word) do
    Enum.member?(@vowels, String.first(word)) ||
      Enum.member?(@vowel_exceptions, String.slice(word, 0..1))
  end

  defp begins_with_vowel?(word), do: Enum.member?(@vowels, String.first(word))

  defp vowel_exception?(word), do: Enum.member?(@vowel_exceptions, String.slice(word, 0..1))

  defp route_word(%{"vowel" => true} = phrase_analysis) do
    translates_vowels(phrase_analysis["phrase"])
  end

  defp route_word(%{"vowel_exception" => true} = phrase_analysis) do
    translates_vowels(phrase_analysis["phrase"])
  end

  defp translates_vowels(word) do
    String.replace_suffix(word, "", "ay")
  end

  # defp consonant_exception?(phrase) do
  #   consonant_exception_2 = Enum.member?(@consonant_exceptions, String.slice(phrase,0..1))
  #   consonant_exception_3 = Enum.member?(@consonant_exceptions, String.slice(phrase,0..2))
  #   # case do
  #   #   consonant_exception_2 == true -> "2ndndndn"
  #   #   consonant_exception_3 == true -> "ndnd"
  #   #   _ -> "final"
  #   # end
  # end
end
