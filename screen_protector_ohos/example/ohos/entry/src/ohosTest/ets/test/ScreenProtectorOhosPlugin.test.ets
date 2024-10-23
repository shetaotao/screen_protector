import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium'
import ScreenProtectorOhosPlugin from 'screen_protector_ohos';

const screenProtectorOhosPlugin: ScreenProtectorOhosPlugin = new ScreenProtectorOhosPlugin()

export default function ScreenProtectorOhosPluginTest() {
  describe('ScreenProtectorOhosPluginTest', () => {
    it('getUniqueClassName', 0, () => {
      expect(screenProtectorOhosPlugin.getUniqueClassName()).assertEqual("ScreenProtectorOhosPlugin");
    });
  })
}