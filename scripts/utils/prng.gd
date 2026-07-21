# ═══════════════════════════════════════════════════════════════
#  MULBERRY32 SEEDED PRNG (prng.gd)
#  Deterministic random number generator for offline simulation
#  Same seed → same results (chống save-scam)
# ═══════════════════════════════════════════════════════════════

class_name PRNG

var _state: int = 0

func _init(seed_value: int = 0) -> void:
	_state = seed_value

func seed(s: int) -> void:
	_state = s

# Mulberry32 algorithm — returns 0.0 to 1.0
func next_float() -> float:
	_state += 0x6D2B79F5
	var t: int = _state
	t = (t ^ (t >> 15)) * (t | 1)
	t ^= t + (t ^ (t >> 7)) * (t | 61)
	var result: int = t ^ (t >> 14)
	return float(result & 0x7FFFFFFF) / float(0x7FFFFFFF)

# Random integer in range [min_val, max_val] inclusive
func next_int(min_val: int, max_val: int) -> int:
	return min_val + int(next_float() * (max_val - min_val + 1))

# Random float in range [min_val, max_val]
func next_range(min_val: float, max_val: float) -> float:
	return min_val + next_float() * (max_val - min_val)

# Roll a chance (0.0 to 1.0). Returns true if roll succeeds.
func roll_chance(chance: float) -> bool:
	return next_float() < chance

# Pick random element from array
func pick(arr: Array):
	if arr.is_empty():
		return null
	return arr[next_int(0, arr.size() - 1)]

# Weighted random pick. weights = [0.6, 0.3, 0.1] etc.
func pick_weighted(items: Array, weights: Array):
	var total: float = 0.0
	for w in weights:
		total += w
	
	var roll: float = next_float() * total
	var cumulative: float = 0.0
	for i in items.size():
		cumulative += weights[i]
		if roll < cumulative:
			return items[i]
	
	return items[items.size() - 1]
