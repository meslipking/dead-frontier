# ═══════════════════════════════════════════════════════════════
#  CONSTANTS & ENUMS (constants.gd) — Autoload Singleton
# ═══════════════════════════════════════════════════════════════
extends Node

# ─── Unit Types ─────────────────────────────────────────────
enum UnitType { SURVIVOR, MONSTER, MECHA }

# ─── Survivor Classes ───────────────────────────────────────
enum SurvivorClass { SCOUT, MEDIC, ENGINEER, SNIPER, BRAWLER, LEADER }

const SURVIVOR_CLASS_NAMES := {
	SurvivorClass.SCOUT: "Trinh sát",
	SurvivorClass.MEDIC: "Y tá",
	SurvivorClass.ENGINEER: "Kỹ sư",
	SurvivorClass.SNIPER: "Xạ thủ",
	SurvivorClass.BRAWLER: "Đấu sĩ",
	SurvivorClass.LEADER: "Thủ lĩnh",
}

# ─── Elements ───────────────────────────────────────────────
enum Element { NONE, FIRE, ICE, POISON, ELECTRIC, SHADOW }

const ELEMENT_NAMES := {
	Element.NONE: "Không",
	Element.FIRE: "Lửa",
	Element.ICE: "Băng",
	Element.POISON: "Độc",
	Element.ELECTRIC: "Điện",
	Element.SHADOW: "Bóng tối",
}

const ELEMENT_COLORS := {
	Element.NONE: Color(0.8, 0.8, 0.8),
	Element.FIRE: Color(0.91, 0.36, 0.23),     # #e85d3a
	Element.ICE: Color(0.31, 0.80, 0.77),       # #4ecdc4
	Element.POISON: Color(0.30, 0.83, 0.22),    # #4dd439
	Element.ELECTRIC: Color(1.0, 0.85, 0.24),   # #ffd93d
	Element.SHADOW: Color(0.58, 0.34, 0.81),    # #9457cf
}

# Element wheel: element_a deals 1.5x to element_b
const ELEMENT_ADVANTAGE := {
	Element.FIRE: Element.ICE,
	Element.ICE: Element.POISON,
	Element.POISON: Element.ELECTRIC,
	Element.ELECTRIC: Element.SHADOW,
	Element.SHADOW: Element.FIRE,
}

# ─── Rarity ─────────────────────────────────────────────────
enum Rarity { COMMON, UNCOMMON, RARE, EPIC, LEGENDARY, MYTHIC }

const RARITY_NAMES := {
	Rarity.COMMON: "Thường",
	Rarity.UNCOMMON: "Khá",
	Rarity.RARE: "Hiếm",
	Rarity.EPIC: "Sử thi",
	Rarity.LEGENDARY: "Huyền thoại",
	Rarity.MYTHIC: "Thần thoại",
}

const RARITY_COLORS := {
	Rarity.COMMON: Color(0.61, 0.64, 0.69),     # #9ca3af
	Rarity.UNCOMMON: Color(0.29, 0.85, 0.50),    # #4ade80
	Rarity.RARE: Color(0.38, 0.65, 0.98),        # #60a5fa
	Rarity.EPIC: Color(0.65, 0.55, 0.98),        # #a78bfa
	Rarity.LEGENDARY: Color(0.98, 0.75, 0.15),   # #fbbf24
	Rarity.MYTHIC: Color(0.96, 0.25, 0.37),      # #f43f5e
}

const RARITY_DROP_RATES := {
	Rarity.COMMON: 0.60,
	Rarity.UNCOMMON: 0.25,
	Rarity.RARE: 0.10,
	Rarity.EPIC: 0.04,
	Rarity.LEGENDARY: 0.008,
	Rarity.MYTHIC: 0.002,
}

# ─── Item Types ─────────────────────────────────────────────
enum ItemType { WEAPON, ARMOR, ACCESSORY, MECHA_PART, MATERIAL, CONSUMABLE }

const ITEM_TYPE_NAMES := {
	ItemType.WEAPON: "Vũ khí",
	ItemType.ARMOR: "Giáp",
	ItemType.ACCESSORY: "Phụ kiện",
	ItemType.MECHA_PART: "Bộ phận Mecha",
	ItemType.MATERIAL: "Nguyên liệu",
	ItemType.CONSUMABLE: "Tiêu hao",
}

# ─── Equipment Slots ────────────────────────────────────────
enum EquipSlot { WEAPON, ARMOR, ACCESSORY }

# ─── Mecha Part Slots ───────────────────────────────────────
enum MechaSlot { HEAD, TORSO, ARMS, LEGS }

const MECHA_SLOT_NAMES := {
	MechaSlot.HEAD: "Đầu",
	MechaSlot.TORSO: "Thân",
	MechaSlot.ARMS: "Tay",
	MechaSlot.LEGS: "Chân",
}

# ─── Monster Evolution Stages ───────────────────────────────
enum EvolutionStage { BABY, JUVENILE, ADULT, ELDER, APEX }

const EVOLUTION_NAMES := {
	EvolutionStage.BABY: "Ấu trùng",
	EvolutionStage.JUVENILE: "Thiếu niên",
	EvolutionStage.ADULT: "Trưởng thành",
	EvolutionStage.ELDER: "Trưởng lão",
	EvolutionStage.APEX: "Đỉnh cao",
}

# ─── Outpost Rooms ──────────────────────────────────────────
enum RoomType { BUNKER, RADIO_TOWER, ARMORY, TRADING_POST, WORKSHOP, BEAST_PEN, MECHA_HANGAR, COMMAND_CENTER }

const ROOM_NAMES := {
	RoomType.BUNKER: "Boong-ke",
	RoomType.RADIO_TOWER: "Đài Phát Sóng",
	RoomType.ARMORY: "Kho Vũ Khí",
	RoomType.TRADING_POST: "Chợ Đen",
	RoomType.WORKSHOP: "Xưởng Máy",
	RoomType.BEAST_PEN: "Chuồng Thú",
	RoomType.MECHA_HANGAR: "Nhà Kho Mecha",
	RoomType.COMMAND_CENTER: "Trung Tâm Chỉ Huy",
}

const ROOM_DESCRIPTIONS := {
	RoomType.BUNKER: "Quản lý đội hình chiến đấu",
	RoomType.RADIO_TOWER: "Tuyển mộ người sống sót mới",
	RoomType.ARMORY: "Kho chứa vũ khí và trang bị",
	RoomType.TRADING_POST: "Mua bán và trao đổi vật phẩm",
	RoomType.WORKSHOP: "Chế tạo trang bị từ nguyên liệu",
	RoomType.BEAST_PEN: "Nuôi dưỡng và tiến hóa quái vật",
	RoomType.MECHA_HANGAR: "Lắp ráp và tùy biến robot chiến đấu",
	RoomType.COMMAND_CENTER: "Thống kê, thành tựu và cài đặt",
}

# ─── Currencies ─────────────────────────────────────────────
enum Currency { GOLD, ALLOYS, ENERGY, CRYSTALS }

const CURRENCY_NAMES := {
	Currency.GOLD: "Vàng",
	Currency.ALLOYS: "Hợp kim",
	Currency.ENERGY: "Năng lượng",
	Currency.CRYSTALS: "Pha lê",
}

# ─── Stats ──────────────────────────────────────────────────
const STAT_NAMES := {
	"hp": "Máu",
	"atk": "Tấn công",
	"def": "Phòng thủ",
	"spd": "Tốc độ",
	"acc": "Chính xác",
	"luck": "May mắn",
}

# ─── Difficulty Stars ───────────────────────────────────────
const MAX_DIFFICULTY := 6
const MAX_UNIT_LEVEL := 50
const MAX_ROOM_LEVEL := 10
const MAX_EQUIPMENT_UPGRADE := 10
const TEAM_MAX_SIZE := 4
const INVENTORY_BASE_CAPACITY := 40
const AUTO_SAVE_INTERVAL := 30.0  # seconds
