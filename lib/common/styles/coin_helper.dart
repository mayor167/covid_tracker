class RCoinHelper {
  static const Map<String, String> _coinNames = {
    'BTC': 'Bitcoin',
    'ETH': 'Ethereum',
    'USDT': 'Tether USDT',
    'N4C': 'mytrader',
    'NGN': 'Nigerian Naira',
    'SOL': "Solana",
    'GloSme': "Glo Sme"
    // Add other coin abbreviations and names as needed
  };

  static String getFullName(String abbreviation) {
    return _coinNames[abbreviation.toUpperCase()] ?? 'Wallet History';
  }
}
