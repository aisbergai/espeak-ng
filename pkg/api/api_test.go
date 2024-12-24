package api

import (
	"fmt"
	"testing"
)

func TestPhonemeParsing(t *testing.T) {
	phonemes, err := TextToPhonemes("Ce, este un test?")
	if err != nil {
		t.Errorf("Error parsing phonemes: %v", err)
		return
	}
	for _, phoneme := range phonemes {
		fmt.Printf("%s\n", phoneme)
		if phoneme.Attributes.PitchEnvelope != "" {
			env := GetPitchEnvelope(phoneme.Attributes.PitchEnvelope, phoneme.Attributes.PitchMin, phoneme.Attributes.PitchMax)
			env = InterpolateEnvelope(env, phoneme.Attributes.LengthMs)
			fmt.Printf("Pitch envelope: %v\n", env)
		}
	}
}
