// Yayındaki ibadet rehberlerinin tek listesi. /rehber/ dizini, footer'daki
// "Rehber" sütunu ve her rehberin altındaki "Diğer rehberler" bu diziden
// beslenir. Yeni rehber = src/pages/rehber/<yol>.astro + buraya bir satır.
export interface Rehber {
  /** URL parçası: /rehber/<yol>/ */
  yol: string;
  /** Kısa ad: menü, footer ve breadcrumb'da görünür */
  kisaAd: string;
  /** Dizin kartındaki bir cümlelik özet */
  ozet: string;
}

export const rehberler: Rehber[] = [
  {
    yol: 'abdest-nasil-alinir',
    kisaAd: 'Abdest nasıl alınır?',
    ozet: 'Adım adım abdest, abdestin farzları ve sünnetleri, abdesti bozan şeyler ve abdest duaları.',
  },
];
