import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/hackernews_jsonparser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;

void main() {
  test("parse top stories", () {
    final topStoriesJson =
        "[24229269,24228651,24229325,24229180,24229864,24222661,24223899,24230522,24228826,24228104,24230447,24222018,24224199,24227663,24222045,24227340,24211714,24224720,24209127,24217758,24220200,24224355,24222629,24223033,24222208,24214548,24227437,24222164,24225685,24222808,24223601,24221708,24222563,24219537,24225592,24222152,24222491,24222186,24229231,24223701,24217116,24227059,24209297,24229315,24229085,24223669,24230035,24207424,24221181,24226979,24222801,24230327,24227074,24222583,24208905,24222289,24224882,24201306,24221885,24223528,24224855,24220278,24193868,24228122,24204461,24216009,24207172,24229756,24207300,24219448,24220785,24210098,24215376,24224759,24212520,24207577,24211414,24224879,24229185,24220149,24208503,24207506,24213867,24220801,24228430,24223018,24220101,24224084,24207660,24214735,24224165,24225402,24223178,24208828,24226021,24228297,24208663,24216582,24228681,24208704,24218961,24221228,24211691,24224362,24198329,24227658,24224048,24227481,24213477,24225526,24228127,24226060,24212325,24224888,24216764,24220517,24225317,24213325,24209073,24196131,24228760,24214570,24198114,24212576,24220628,24215022,24200764,24208815,24208390,24228424,24209043,24215850,24203114,24224823,24189341,24211345,24210470,24227896,24196031,24215572,24223681,24213347,24215818,24206308,24222123,24196706,24222038,24210991,24210592,24197668,24211093,24220888,24228564,24226130,24205416,24208726,24214758,24221824,24208571,24212251,24210297,24227268,24210952,24195600,24222260,24218362,24209865,24204797,24225823,24209948,24206727,24197528,24190661,24225724,24197395,24196836,24208958,24221549,24225518,24225505,24212784,24213941,24217592,24209374,24208126,24211034,24220241,24226281,24229854,24195751,24195911,24196080,24191743,24199419,24216290,24220668,24209940,24208108,24204323,24210717,24199595,24212628,24216441,24211689,24195000,24202773,24222557,24212585,24212199,24210767,24199424,24196433,24222441,24193396,24196237,24195122,24195375,24209355,24217683,24197026,24212021,24211045,24219019,24219682,24196025,24211033,24220702,24203327,24195566,24189497,24210623,24204718,24218964,24207502,24213207,24195595,24209025,24196070,24196057,24207635,24200048,24223496,24215418,24196417,24224718,24224704,24204538,24195627,24196490,24218018,24206899,24198172,24221632,24203727,24224452,24204478,24224403,24209671,24222463,24219387,24189582,24216111,24197579,24218044,24217096,24221065,24189695,24221010,24202308,24229069,24192408,24219098,24204171,24223759,24223876,24199806,24199202,24205363,24196121,24190385,24205833,24192117,24210560,24196989,24210180,24213118,24228560,24199767,24203495,24206196,24200924,24189153,24194747,24198228,24197310,24221816,24197425,24201369,24210472,24205285,24193278,24201651,24194432,24207953,24190712,24209944,24222295,24200854,24191184,24196650,24193313,24224514,24190011,24209611,24214102,24195129,24194543,24213849,24225869,24189054,24205479,24200795,24189580,24220408,24193795,24221879,24208699,24208443,24190086,24206738,24216031,24208145,24199545,24202354,24196625,24203773,24216434,24189723,24219479,24190897,24212691,24224627,24223228,24220211,24196052,24190556,24209663,24205888,24197701,24220123,24211657,24209487,24215591,24195667,24218984,24189801,24219894,24213643,24203806,24216977,24193836,24191359,24197920,24189147,24194640,24208450,24225935,24194407,24219314,24216675,24212326,24224558,24207306,24191164,24217787,24217477,24191529,24197532,24204281,24200337,24218611,24202351,24193168,24201363,24219808,24194482,24218078,24220915,24204024,24190724,24219632,24200642,24202144,24198312,24217355,24200848,24192511,24213880,24195745,24205633,24213220,24219203,24216648,24194653,24216455,24213754,24220809,24189237,24196228,24194101,24198857,24201846,24206761,24202584,24209207,24211994,24212202,24198767,24211733,24211698,24211554,24191020,24199239,24189867,24200864,24222032,24194966,24198975,24198567,24212037,24193609,24220417,24220178,24211256,24206608,24194673,24206448,24214429,24222549,24191636,24191120,24190900,24190875,24205966,24195145,24190640,24190649,24209947,24203579,24209892,24189085,24203191,24200047,24206540,24199479,24219518,24191199,24204678,24194155,24201701,24193146,24200263,24194574,24193945,24195868,24211515,24194769,24223860,24194681,24192972,24206447,24204112,24204014,24221551,24191503,24206829,24191332,24210171,24210139,24190412,24189666,24196875,24191748,24195046,24190568,24212574,24194102,24203098,24220546,24206819,24205460,24200328,24190547,24205314,24199423,24192665,24200992,24198586,24195983,24225704]";

    expect(parseStories(topStoriesJson).first, 24229269);
  });
  test("parse article", () {
    final itemJson = """{"by":"vaillancourtmax","descendants":36,"id":24228651,"kids":[24230607,24229407,24230014,24229378,24229641,24230340,24229070,24230177,24229377,24229777,24229292],"score":185,"time":1597955942,"title":"How Shopify reduced storefront response times with a rewrite","type":"story","url":"https://engineering.shopify.com/blogs/engineering/how-shopify-reduced-storefront-response-times-rewrite"}""";

    expect(parseArticle(itemJson).by, "vaillancourtmax");
  });

  test("parse article via network", () async {
    final bestStoriesEndpoint = 'https://hacker-news.firebaseio.com/v0/beststories.json';
    var bestStoriesResponse = await http.get(bestStoriesEndpoint);
    if (bestStoriesResponse.statusCode == 200) {
      List bestStoriesIds = json.jsonDecode(bestStoriesResponse.body);
      final itemEndpoint = 'https://hacker-news.firebaseio.com/v0/item/${bestStoriesIds.first}.json';
      var itemResponse = await http.get(itemEndpoint);

      if (itemResponse.statusCode == 200) {
        print(itemResponse.body);
        expect(parseArticle(itemResponse.body).title, isNotEmpty);
      } else {
        fail("Unable to get item from $itemEndpoint");
      }
    } else {
      fail("Unable to get best stories from $bestStoriesEndpoint.");
    }
  });

}
